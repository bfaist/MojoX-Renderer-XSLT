package xslttest::Tester;

use strict;
use warnings;

use base 'Mojolicious::Controller';

# This action will render a template
sub test1 {
    my $self = shift;

    $self->stash->{xml} = '<root><para>Stuff Here</para></root>';
    $self->render(template => 'test1.xsl');
}

sub test2 {
    my $self = shift;

    $self->stash->{xml} = '<root><para>Stuff Here</para></root>';
    $self->render(template => 'test1.xsl');
}

sub test3 {
    my $self = shift;

    $self->stash->{xml} = '<root><para>Stuff Here</para></root>';
    $self->render(template => 'test1.xsl');
}

1;
