package MojoX::Renderer::XSLT::XML::LibXSLT;

use warnings;
use strict;

use base 'Mojo::Base';
use XML::LibXML;
use XML::LibXSLT;

=head1 NAME

MojoX::Renderer::XSLT::XML::LibXSLT - The great new MojoX::Renderer::XSLT::XML::LibXSLT!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use MojoX::Renderer::XSLT::XML::LibXSLT;

    my $foo = MojoX::Renderer::XSLT::XML::LibXSLT->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 FUNCTIONS

=head2 new

Constructor

=cut

sub new {
    my $class = shift;
    my $self = $class->SUPER::new();
    $self->_init(@_);
    return $self;
}

sub _init {
    my $self = shift;
    my $params = shift;

    $self->{_xslt_processor} = XML::LibXSLT->new();
    $self->{_xml_parser} = XML::LibXML->new();
  
    if($params) {
        $self->{_xslt_processor}->max_depth($params->{max_depth}) if exists $params->{max_depth} && defined $params->{max_depth};
    
        $self->{_xslt_processor}->debug_callback($params->{debug_callback}) if exists $params->{debug_callback} && defined $params->{debug_callback};
    
        if(exists $params->{register_function} && ref($params->{register_function}) eq "ARRAY") {
            foreach my $reg (@{ $params->{register_function} }) {
                 $self->{_xslt_processor}->register_function($reg->{urn},
                                                             $reg->{name},
                                                             $reg->{subref});
            }
        }
    }
}

=head3 transform

Parse XML and stylesheet into XML::LibXML document objects.  Do XSLT transform.

=cut

sub transform {
    my $self = shift;
    my ($stylesheet,$xml) = @_;

    return undef unless $stylesheet && $xml;

    my $xml_doc = $self->{_xml_parser}->parse_string($xml) or die "Failure to parse XML $xml $@";
    my $style_doc = $self->{_xml_parser}->parse_file($stylesheet) or die "Failure to parse stylesheet $stylesheet $@";
    my $parsed_stylesheet =  $self->{_xslt_processor}->parse_stylesheet($style_doc) or die "Failure to parse style doc $@";
    my $results = $parsed_stylesheet->transform($xml_doc) or die "Failure to do XSLT transform $@"; 
    return $parsed_stylesheet->output_as_bytes($results);
}

=head1 AUTHOR

Bob Faist, C<< <bfaist at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-mojox-renderer-xslt at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=MojoX-Renderer-XSLT>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc MojoX::Renderer::XSLT::XML::LibXSLT


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

1; # End of MojoX::Renderer::XSLT::XML::LibXSLT
