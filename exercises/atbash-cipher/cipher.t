#!/usr/bin/env perl6

use Test;
use JSON::Tiny;

use lib ( my $dir = IO::Path.new($?FILE).parent ).path;

my $module_name = %*ENV<EXERCISM>.so ?? 'Example' !! 'Allergies';
my @potential_module = <p6 pm6 pm>.map:  $module_name ~ '.' ~ *; 

my $module = first { $dir.child($_).e }, |@potential_module
    or die "No file '$module_name.p6' found\n";

require $module <&encode &decode>;

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

done-testing;
