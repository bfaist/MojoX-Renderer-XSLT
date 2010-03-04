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

Quick summary of what the module does.

Perhaps a little code snippet.

    use MojoX::Renderer::XSLT;

    my $foo = MojoX::Renderer::XSLT->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 FUNCTIONS

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

=head3 build

=cut

sub build {
  my $class = shift;

  my ($xslt_class, $params);
  if ($_[0] && $_[0] =~ /\Axslt_/) {
    my %args = @_;
    $xslt_class = $args{xslt_class};
    $params = $args{xslt_params};
  }
  else {
    $params = \@_;
  }

  # fallback to XML::LibXSLT as default encoder class if needed
  $xslt_class ||= 'XML::LibXSLT';

  my $xslt = $class->_create_xslt($xslt_class,$params);

  return sub {
    my ($mojo, $ctx, $output, $options) = @_;
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
