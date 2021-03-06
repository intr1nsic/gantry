package Gantry::Control::C::AuthzBase;

use strict;

use constant MP2 => (
    exists $ENV{MOD_PERL_API_VERSION} and
    $ENV{MOD_PERL_API_VERSION} >= 2 
);

# must explicitly import for mod_perl2
BEGIN {
    if (MP2) {
        require Gantry::Engine::MP20;
        Gantry::Engine::MP20->import();
    }
}

######################################################################
# Main Execution Begins Here                                         #
######################################################################
sub handler : method {
    my ( $self, $r ) = @_;

    my $user_model          = $self->user_model();
    my $group_members_model = $self->group_members_model();

    # Check Exclude paths
    if ( $r->dir_config( 'exclude_path' ) ) {
        foreach my $p ( split( /\s*;\s*/, $r->dir_config( 'exclude_path' ) ) ) {
            if ( $r->path_info =~ /^$p$/ ) {
                $user_model->dbi_rollback();
                
                return( $self->status_const( 'OK' ) );
            }
        }
    } # end if exclude_path

    my $user = $r->user;

    if ( $user ) {
        my $requires = $r->requires;
        my %groups;

        unless ( $requires ) {
            $user_model->dbi_rollback();

            return( $self->status_const( 'DECLINED' ) );
        }

        # get user id
        my @user_row = $user_model->search( user_name => $user ); 

        # get groups for user
        my @group_rows = $group_members_model->search( 
            user_id => $user_row[0]->user_id
        );

        foreach ( @group_rows ) {
            $groups{$_->group_id->name} = 1;
        }

        $group_members_model->dbi_rollback();

        # Check out what we have to auth against.
        for my $entry ( @$requires ) {
            my ( $req, @rest ) = split( /\s+/, $entry->{requirement} );
            $req = lc( $req );

            if ( $req eq 'valid-user' ) {
                #$r->log_error( "authz: valid-user $user" );
                $user_model->dbi_rollback();
                return( $self->status_const( 'OK' ) );
            }
            elsif ( $req eq 'user' ) {
                for ( @rest ) { 
                    #$r->log_error( "authz: user check $user $_ " );
                    
                    if ( $user eq $_ ) {
                        $user_model->dbi_rollback();
                        return( $self->status_const( 'OK' ) );
                    }
                }
            }
            elsif ( $req eq 'group' ) {
                for ( @rest ) {
                    if ( exists $groups{$_} ) {
                        $user_model->dbi_rollback();
                        return( $self->status_const( 'OK' ) );
                    }
                }
            }
            else {
                $r->log_error( "authz: unknown $req" );
            }

        }
    } # end: if user

    $r->note_basic_auth_failure;
    $user_model->dbi_rollback();

    return( $self->status_const( 'HTTP_UNAUTHORIZED' ) );

} # END $self->handler

#-------------------------------------------------
# $self->import( $self, @options )
#-------------------------------------------------
sub import {
    my ( $self, @options ) = @_;
    
    my( $engine, $tplugin );
    
    foreach (@options) {
        
        # Import the proper engine
        if (/^-Engine=(.*)$/) { 
            $engine = "Gantry::Engine::$1";
            eval( "use $engine" ); 
            if ( $@ ) {
                die "unable to load engine $1 ($@)";
            }   
        }
        
    }
    
} # end: import
# EOF
1;

__END__

=head1 NAME 

Gantry::Control::C::AuthzBase - Database based authorization.

=head1 SYNOPSIS

  use Gantry::Control::C::AuthzSubClass qw/-Engine=MP20/;

=head1 DESCRIPTION

This is a simple database driven autorization system. This module also
details the other Authz modules in the library.  There are two subclasses:
Gantry::Control::C::AuthzRegular and Gantry::Control::C::AuthzCDBI.
Use CDBI if you use Class::DBI (or anything descended from it), otherwise
use Regular.

=head1 APACHE

Sample Apache conf configuration.

  <Perl>
     use Gantry::Control::C::Authz qw/-Engine=MP20/;
  </Perl>
  
  <Location /location/to/auth >
    AuthType    Basic
    AuthName    "Manual"

    PerlSetVar  auth_dbconn     'dbi:Pg:dbname=...'
    PerlSetVar  auth_dbuser     '<database_user>'
    PerlSetVar  auth_dbpass     '<database_password>'
    
    PerlSetVar  auth_dbcommit   off

    PerlAuthzHandler  Gantry::Control::C::AuthzSubclass

    require     group "group_to_require"
  </Location>

Pick an AuthzSubclass, see the DESCRIPTION for advice.

=head1 DATABASE 

These are the tables that will be queried for the authorization of the
user. 

  create table "auth_users" (
    "id"            int4 default nextval('auth_users_seq') NOT NULL,
    "user_id"       int4,
    "active"        bool,
    "user_name"     varchar,
    "passwd"        varchar,
    "crypt"         varchar,
    "first_name"    varchar,
    "last_name"     varchar,
    "email"         varchar
  );

  create table "auth_groups" (
    "id"            int4 default nextval('auth_groups_seq') NOT NULL,
    "ident"         varchar,
    "name"          varchar,
    "description"   text
  );

  create table "auth_group_members" (
    "id"        int4 default nextval('auth_group_members_seq') NOT NULL,
    "user_id"   int4,
    "group_id"  int4    
  );

  create table "auth_pages" (
    "id"          int4 default nextval('auth_pages_seq') NOT NULL,
    "user_perm"   int4,
    "group_perm"  int4,
    "owner_id"    int4,
    "group_id"    int4,
    "uri"         varchar,
    "title"       varchar
  );

=head1 MODULES

=over 4

=item Gantry::Control::C::Authz::PageBased

This handler is the authorization portion for page based authorization.
It is controlled by Gantry::Control::C::Pages(3) and will authenticat only
users who have been allowed from the administrative interface into a
particular uri. The module returns FORBIDDEN if you do not have access
to a particular uri.

=back

=head1 METHODS

=over 4

=item handler

The mod_perl authz handler.

=back

=head1 SEE ALSO

Gantry::Control::C::Authen(3), Gantry::Control(3), Gantry(3)

=head1 LIMITATIONS


=head1 AUTHOR

Tim Keefer <tkeefer@gmail.com>
Nicholas Studt <nstudt@angrydwarf.org>

=head1 COPYRIGHT

Copyright (c) 2005-6, Tim Keefer.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.6 or,
at your option, any later version of Perl 5 you may have available.

=cut
