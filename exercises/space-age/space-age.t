#!/usr/bin/env perl6

use Test;
use JSON::Tiny;

use lib ( my $dir = IO::Path.new($?FILE).parent ).path;

my $module = %*ENV<EXERCISM> ?? 'Example' !! 'SpaceAge';
require ::($module) <&age-on>;

plan 8;

my %testcase = from-json $dir.child('cases.json').slurp;

for |%testcase{'age on'}{'cases'} -> %case {
        is age-on( |%case<planet seconds>), %case{'expected'},
             %case<planet seconds>.gist;
}
