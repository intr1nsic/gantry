package Gantry::Samples;

use strict;

our $VERSION = '0.03';

use base 'Gantry::GENSamples';

use Gantry::Plugins::Static;
use Gantry::Samples::FileUpload;
use Gantry::Samples::AjaxRequest;

use Gantry::Samples::Model;
sub schema_base_class { return 'Gantry::Samples::Model'; }
use Gantry::Plugins::DBIxClassConn qw( get_schema );

##-----------------------------------------------------------------
## $self->init( $r )
##-----------------------------------------------------------------
sub init {
    my ( $self, $r ) = @_;

    # process SUPER's init code
    $self->SUPER::init( $r );

} # END init

1;

=head1 NAME

Gantry::Samples - the base module of this web app

=head1 SYNOPSIS

This package is meant to be used in a stand alone server/CGI script or the
Perl block of an httpd.conf file.

Stand Alone Server or CGI script:

    use Gantry::Samples;

    my $cgi = Gantry::Engine::CGI->new( {
        config => {
            #...
        },
        locations => {
            '/' => 'Gantry::Samples',
            #...
        },
    } );

httpd.conf:

    <Perl>
        # ...
        use Gantry::Samples;
    </Perl>

If all went well, one of these was correctly written during app generation.

=head1 DESCRIPTION

This module was originally generated by Bigtop.  But feel free to edit it.
You might even want to describe the table this module controls here.

=head1 METHODS (inherited from Gantry::GENSamples)

=over 4

=item init

=item do_main

=item site_links


=back


=head1 SEE ALSO

    Gantry
    Gantry::GENSamples
    Gantry::Samples::FileUpload
    Gantry::Samples::AjaxRequest

=head1 AUTHOR

Phil Crow, E<lt>pcrow@localdomainE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2006 Phil Crow

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.6 or,
at your option, any later version of Perl 5 you may have available.

=cut
