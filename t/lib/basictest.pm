package basictest;

use strict;
use warnings;

use base 'Mojolicious';
use MojoX::Renderer::XSLT;

# This method will run once at server start
sub startup {
    my $self = shift;

    $self->types->type(xsl => 'text/html');

    my $renderer = MojoX::Renderer::XSLT->build();

    $self->renderer->add_handler(xsl => $renderer);
    $self->renderer->default_handler('xsl');

    # Routes
    my $r = $self->routes;

    $r->route('/test1')->to('tester#test1');
    $r->route('/test2')->to('tester#test2');
}

1;
