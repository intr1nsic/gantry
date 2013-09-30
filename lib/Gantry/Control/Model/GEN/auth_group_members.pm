# NEVER EDIT this file.  It was generated and will be overwritten without
# notice upon regeneration of this application.  You have been warned.
package Gantry::Control::Model::GEN::auth_group_members;
use strict; use warnings;

use base 'Gantry::Utils::Model::Auth';

use Carp;

sub get_table_name    { return 'auth_group_members'; }

sub get_primary_col   { return 'id'; }

sub get_essential_cols {
    return 'id, user_id, group_id';
}

sub get_primary_key {
    goto &id;
}

sub id {
    my $self  = shift;
    my $value = shift;

    if ( defined $value ) {
        return $self->set_id( $value );
    }

    return $self->get_id();
}

sub set_id {
    croak 'Can\'t change primary key of row';
}

sub get_id {
    my $self = shift;
    return $self->{id};
}

sub quote_id {
    return $_[1];
}

sub group_id {
    my $self  = shift;
    my $value = shift;

    if ( defined $value ) { return $self->set_group_id( $value ); }
    else                  { return $self->get_group_id();         }
}

sub set_group_id {
    my $self  = shift;
    my $value = shift;

    if ( ref $value ) {
        $self->{group_id_REF} = $value;
        $self->{group_id}     = $value->id;
    }
    elsif ( defined $value ) {
        delete $self->{group_id_REF};
        $self->{group_id}     = $value;
    }
    else {
        croak 'set_group_id requires a value';
    }

    $self->{__DIRTY__}{group_id}++;

    return $value;
}

sub get_group_id {
    my $self = shift;

    if ( not defined $self->{group_id_REF} ) {
        $self->{group_id_REF}
            = Gantry::Control::Model::auth_groups->retrieve_by_pk(
                    $self->{group_id}
              );

        $self->{group_id}     = $self->{group_id_REF}->get_primary_key()
                if ( defined $self->{group_id_REF} );
    }

    return $self->{group_id_REF};
}

sub get_group_id_raw {
    my $self = shift;

    if ( @_ ) {
        croak 'get_group_id_raw is only a get accessor, pass it nothing';
    }

    return $self->{group_id};
}

sub quote_group_id {
    return 'NULL' unless defined $_[1];
    return ( ref( $_[1] ) ) ? "$_[1]" : $_[1];
}

sub user_id {
    my $self  = shift;
    my $value = shift;

    if ( defined $value ) { return $self->set_user_id( $value ); }
    else                  { return $self->get_user_id();         }
}

sub set_user_id {
    my $self  = shift;
    my $value = shift;

    if ( ref $value ) {
        $self->{user_id_REF} = $value;
        $self->{user_id}     = $value->id;
    }
    elsif ( defined $value ) {
        delete $self->{user_id_REF};
        $self->{user_id}     = $value;
    }
    else {
        croak 'set_user_id requires a value';
    }

    $self->{__DIRTY__}{user_id}++;

    return $value;
}

sub get_user_id {
    my $self = shift;

    if ( not defined $self->{user_id_REF} ) {
        $self->{user_id_REF}
            = Gantry::Control::Model::auth_users->retrieve_by_pk(
                    $self->{user_id}
              );

        $self->{user_id}     = $self->{user_id_REF}->get_primary_key()
                if ( defined $self->{user_id_REF} );
    }

    return $self->{user_id_REF};
}

sub get_user_id_raw {
    my $self = shift;

    if ( @_ ) {
        croak 'get_user_id_raw is only a get accessor, pass it nothing';
    }

    return $self->{user_id};
}

sub quote_user_id {
    return 'NULL' unless defined $_[1];
    return ( ref( $_[1] ) ) ? "$_[1]" : $_[1];
}

sub get_foreign_display_fields {
    return [ qw(  ) ];
}

sub get_foreign_tables {
    return qw(
        Gantry::Control::Model::auth_users
        Gantry::Control::Model::auth_groups
    );
}

sub foreign_display {
    my $self = shift;

}

1;

=head1 NAME

Gantry::Control::Model::GEN::auth_group_members - model for auth_group_members table

=head1 METHODS

=over 4

=item foreign_display

=item get_essential_cols

=item get_foreign_display_fields

=item get_foreign_tables

=item get_group_id

=item get_group_id_raw

=item get_id

=item get_primary_col

=item get_primary_key

=item get_sequence_name

=item get_table_name

=item get_user_id

=item get_user_id_raw

=item group_id

=item id

=item quote_group_id

=item quote_id

=item quote_user_id

=item set_group_id

=item set_id

=item set_user_id

=item user_id

=back

=head1 AUTHOR

Generated by Bigtop, please don't edit.

=cut