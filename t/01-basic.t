#!perl

use Test::More;
use Test::Mojo;
use FindBin;

plan tests => 7;

use lib "$FindBin::Bin/lib";

my $t = Test::Mojo->new(app => 'basictest');

use_ok('basictest');

$ENV{MOJO_MODE} = 'production';

$t->get_ok('/test1')->status_is(200)->content_like(qr/Stuff Here/);
$t->get_ok('/test2')->status_is(200)->content_like(qr/Introduction/);
