#!/usr/bin/env perl6

use Test;
use JSON::Tiny;

use lib ( my $dir = IO::Path.new($?FILE).parent ).path;

my $module_name = %*ENV<EXERCISM>.so ?? 'Example' !! 'SpaceAge';
my @potential_module = <p6 pm6 pm>.map:  $module_name ~ '.' ~ *; 

my $module = first { $dir.child($_).e }, |@potential_module
    or die "No file '$module_name.p6' found\n";

require $module <&age-on>;

plan 8;

my %testcase = from-json $dir.child('cases.json').slurp;

for |%testcase{'age on'}{'cases'} -> %case {
        is age-on( |%case<planet seconds>), %case{'expected'},
             %case<planet seconds>.gist;
}
