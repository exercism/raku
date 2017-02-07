#!/usr/bin/env perl6

use Test;
use JSON::Tiny;

use lib ( my $dir = IO::Path.new($?FILE).parent ).path;

my $module = %*ENV<EXERCISM> ?? 'Example' !! 'Cipher';
require ::($module) <&encode &decode>;

plan 2;

my %cases = from-json $dir.child('cases.json').slurp;

subtest 'encode' => {
    my @cases = |%cases.<encode>.<cases>;

    plan +@cases;

    is encode( .<phrase> ), .<expected>, .<description>
        for @cases;
};

subtest 'decode' => {
    my @cases = |%cases.<decode>.<cases>;

    plan +@cases;

    is decode( .<phrase> ), .<expected>, .<description>
        for @cases;
};
