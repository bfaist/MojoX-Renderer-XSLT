#!perl

use Test::More;
use Test::Mojo;
use FindBin;

plan tests => 4;

use lib "$FindBin::Bin/lib";

my $t = Test::Mojo->new(app => 'xslttest');

use_ok('xslttest');

$ENV{MOJO_MODE} = 'production';

$t->get_ok('/test1')->status_is(200)->content_like(qr/Stuff Here/);
