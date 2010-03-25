package basictest::Tester;

use strict;
use warnings;

use base 'Mojolicious::Controller';

# This action will render a template
sub test1 {
    my $self = shift;

    $self->stash->{xml} = '<root><para>Stuff Here</para></root>';
    $self->render(template => 'basic_test1.xsl');
}

sub test2 {
    my $self = shift;

    $self->stash->{xml} = '<doc><chapter><title>Title</title><intro>Introduction</intro></chapter></doc>';
    $self->render(template => 'basic_test2.xsl');
}

1;
