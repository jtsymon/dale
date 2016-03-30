#!/usr/bin/perl

use warnings;
use strict;
$ENV{"DALE_TEST_ARGS"} ||= "";
my $test_dir = $ENV{"DALE_TEST_DIR"} || ".";
$ENV{PATH} .= ":.";

use Data::Dumper;
use Test::More tests => 3;

my @res = `dalec $ENV{"DALE_TEST_ARGS"} -lm $test_dir/t/src/vector-rv.dt -o vector-rv `;
is_deeply(\@res, [], 'No compilation errors');
@res = `./vector-rv`;
is($?, 0, 'Program executed successfully');

chomp for @res;

is_deeply(\@res, [
'Empty?: 1',
'Unique pointer has value: 1',
'Empty?: 0',
'Unique pointer has value: 0',
'Unique pointer has value: 0',
'Unique pointer has value: 1',
'200',
'Size: 1',
'Unique pointer has value: 0',
'Unique pointer has value: 1',
'100',
'Size: 0',
],
    'Got correct results');

`rm vector-rv`;

1;
