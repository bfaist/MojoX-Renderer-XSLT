package paramtest;

use strict;
use warnings;

use base 'Mojolicious';
use MojoX::Renderer::XSLT;

# This method will run once at server start
sub startup {
    my $self = shift;

    $self->types->type(xsl => 'text/html');

    my $renderer = MojoX::Renderer::XSLT->build(
                           max_depth => 1000, 
                           register_function => [ { urn => 'urn:test',
                                                    name => 'time',
                                                    subref => sub { return time(); } },
                                                  { urn => 'urn:test',
                                                    name => 'uc',
                                                    subref =>  sub { return uc($_[0]); } }
                                                ]);

    $self->renderer->add_handler(xsl => $renderer);
    $self->renderer->default_handler('xsl');

    # Routes
    my $r = $self->routes;

    $r->route('/test1')->to('tester#test1');
    $r->route('/test2')->to('tester#test2');
}

1;
