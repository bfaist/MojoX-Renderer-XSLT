use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'MojoX::Renderer::XSLT',
    license             => 'perl',
    dist_author         => 'Bob Faist <bfaist@cpan.org>',
    dist_version_from   => 'lib/MojoX/Renderer/XSLT.pm',
    build_requires => {
        'Test::More' => 0.92,
        'XML::LibXML' => 1.69,
        'XML::LibXSLT' => 1.68,
        'FindBin' => 1.49,
        'Mojo' => 0.999923,
    },
    add_to_cleanup      => [ 'MojoX-Renderer-XSLT-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
