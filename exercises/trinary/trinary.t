#!/usr/bin/env perl6

use Test;

use lib ( my $dir = IO::Path.new($?FILE).parent ).path;

my $module = %*ENV<EXERCISM> ?? 'Example' !! 'Trinary';
require ::($module) <&to-decimal>;

my @cases = (
    {
        input    => 1,
        expected => 1,
    },
    {
        input    => 2,
        expected => 2,
    },
    {
        input    => 10,
        expected => 3,
    },
    {
        input    => 11,
        expected => 4,
    },
    {
        input    => 100,
        expected => 9,
    },
    {
        input    => 10,
        expected => 3,
    },
    {
        input    => 112,
        expected => 14,
    },
    {
        input    => 222,
        expected => 26,
    },
    {
        input    => 1122000120,
        expected => 32091,
    },
    {
        input    => "carrot",
        expected => 0,
    }
);

plan @cases.elems;

is to-decimal( .<input> ), .<expected>, .<input> for @cases;
