package Coolinar;
use Moose;
use namespace::autoclean;

use Catalyst::Runtime 5.80;

# Set flags and add plugins for the application.
#
# Note that ORDERING IS IMPORTANT here as plugins are initialized in order,
# therefore you almost certainly want to keep ConfigLoader at the head of the
# list if you're using it.
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root
#                 directory
#    Unicode::Encoding - removede for now
use Catalyst qw/
    ConfigLoader
    Static::Simple


    Authentication

    Session
    Session::Store::File
    Session::State::Cookie
    
    StatusMessage

    Cache
/;

extends 'Catalyst';

our $VERSION = '0.01';

# Configure the application.
#
# Note that settings in coolinar.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with an external configuration file acting as an override for
# local deployment.

__PACKAGE__->config(
    name => 'Coolinar',

    # Disable deprecated behavior needed by old applications
    disable_component_resolution_regex_fallback => 1,
    enable_catalyst_header                      => 1, # Send X-Catalyst header

    'View::HTML' => {
	INCLUDE_PATH => [
	    __PACKAGE__->path_to('root', 'src'),
	    ],
    },

    'Plugin::Authentication' => {
	default => {
	    class          => 'SimpleDB',
	    user_model     => 'DB::User',
#	    password_type  => 'clear',
	    password_type  => 'self_check',
	    password_field => 'pass',
	},
    },

    'Plugin::Cache' => {
	backend => {
	    class   => 'Cache::Memcached::libmemcached',
	    servers => [ "$ENV{HOME}/var/memd.sock" ],
#	    debug   => 2,
	    behaviour_binary_protocol => 1,
	},
    },

    default_view => 'HTML',
    encoding     => 'utf-8',
);


#
# Globals
#
__PACKAGE__->config->{REC_PER_PAGE} = 6;
__PACKAGE__->config->{PAGES_IN_BAR} = 5;


# Start the application
__PACKAGE__->setup();

=encoding utf8

=head1 NAME

Coolinar - Catalyst based application

=head1 SYNOPSIS

    script/coolinar_server.pl

=head1 DESCRIPTION

Recipes list demo application. Intended to be introducionary ro Catalyst development.

=head1 SEE ALSO

L<Coolinar::Controller::Root>, L<Catalyst>

=head1 AUTHOR

Alex Karev - (Not yet) Cool Catalyst developer

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
