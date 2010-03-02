#!perl -T

use Test::More tests => 2;

BEGIN {
	use_ok( 'MojoX::Renderer::XSLT' );
	use_ok( 'MojoX::Renderer::XSLT::XML::LibXSLT' );
}

diag( "Testing MojoX::Renderer::XSLT $MojoX::Renderer::XSLT::VERSION, Perl $], $^X" );
