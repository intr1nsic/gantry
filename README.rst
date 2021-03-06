Gantry version 3.30
==========================

Gantry is a Perl Web App Framework.

See Gantry::Docs::QuickStart to get started.

INSTALLATION

To install this module:

    perl Build.PL
    ./Build
    ./Build test
    ./Build install

During installation you will be asked for a 'Web Directory'.  Gantry
uses this to store templates for its CRUD schemes and other things.
It is called a 'Web Directory' since your web server must be willing
to serve files from it.  Typically, it is enough to make this a subdirectory
of your document root.

DEPENDENCIES

This module requires these other modules and libraries:

    Template
    CGI::Simple
    URI
    Data::UUID
    DBI
    File::Copy::Recursive
    HTTP::Server::Simple::CGI

Some of Gantry's parts require these modules:

    Module                  Used by
    -------------------------------------------------------
    Data::FormValidator     Gantry::Plugins::AutoCRUD
                            Gantry::Plugins::CRUD
                            Gantry::Control::C::Pages
                            Gantry::Control::C::Groups

    Date::Calc              Gantry::Plugins::Calendar
                            Gantry::Plugins::Validate
                            Gantry::Utils::Validate

    Hash::Merge             Gantry::Conf

    Config::General         Gantry::Conf

    HTML::Prototype         Gantry::Control::C::Groups

Gantry provides explicit support for these modules:

    Module                  Supported by
    --------------------------------------------------------
    Class::DBI::Sweet       Gantry::Utils::CDBI
                            Gantry::Utils::AuthCDBI
                            Gantry::Plugins::AutoCRUDHelper::CDBI

    DBIx::Class             Gantry::Utils::DBIxClass (regular and auth)
                            Gantry::Plugins::DBIxClassConn
                            Gantry::Plugins::AutoCRUDHelper::DBIxClass

SUPPORT

Please join the gantry mailing list for support.  Visit
http://www.usegantry.org and click on the mailing list tab for instructions.

COPYRIGHT AND LICENSE

Copyright (c) 2005-6 by Tim Keefer.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.6 or,
at your option, any later version of Perl 5 you may have available.

