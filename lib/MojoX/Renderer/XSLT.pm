package MojoX::Renderer::XSLT;

use warnings;
use strict;

=head1 NAME

MojoX::Renderer::XSLT - The great new MojoX::Renderer::XSLT!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

This module enables a Mojo / Mojolicious app to render output using XSLT stylesheets.

    use MojoX::Renderer::XSLT;

    sub startup {
        my $self = shift;
    
        $self->types->type(xsl => 'text/html');
    
        my $renderer = MojoX::Renderer::XSLT->build();
    
        $self->renderer->add_handler(xsl => $renderer);
        $self->renderer->default_handler('xsl');
    
        # Routes
        my $r = $self->routes;

        ...
    }

=head1 FUNCTIONS

=head2 _create_xslt

Used internally only to instantiate a wrapper class which handles the XSLT parsing and transform.

=cut

sub _create_xslt {
  my ($self, $class, $params) = @_;

  unless ($class =~ /\A[\w:]+\z/) {
    die "invalid xslt_class '$class'";
  }

  # class = MojoX::Renderer::XSLT:: + XML::LibXSLT
  $class = 'MojoX::Renderer::XSLT::' . $class unless $class =~ m/^MojoX::Renderer::XSLT/;

  eval "require $class";
  die "can't load '$class': $@" if $@;

  return defined($params) ? $class->new($params) : $class->new();
}

=head2 build

This method is used to build an anonymous closure function which can be added as a handler for rendering output.

=cut

sub build {
  my $class = shift;
  my %params = @_;

  # fallback to XML::LibXSLT as default encoder class if needed
  my $xslt_class = $params{xslt_class} || 'XML::LibXSLT';

  my $xslt = $class->_create_xslt($xslt_class,\%params);

  # return closure which will become render handler
  return sub {
    my ($mojo, $ctx, $output, $options) = @_;
    # TODO:  Should templates be in controller specific dirs?
    my $template = $ctx->app->home->rel_file('templates/' . $options->{template});
    $$output = $xslt->transform($template,$ctx->stash->{xml});
    return 1;
  };
}

=head1 AUTHOR

Bob Faist, C<< <bfaist at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-mojox-renderer-xslt at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=MojoX-Renderer-XSLT>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc MojoX::Renderer::XSLT


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=MojoX-Renderer-XSLT>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/MojoX-Renderer-XSLT>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/MojoX-Renderer-XSLT>

=item * Search CPAN

L<http://search.cpan.org/dist/MojoX-Renderer-XSLT/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2010 Bob Faist, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


=cut

1; # End of MojoX::Renderer::XSLT
