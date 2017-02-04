#!/usr/bin/env perl6

use Test;
use JSON::Tiny;

use lib ( my $dir = IO::Path.new($?FILE).parent ).path;

my $module_name = %*ENV<EXERCISM>.so ?? 'Example' !! 'Wordy';
my @potential_module = <p6 pm6 pm>.map:  $module_name ~ '.' ~ *; 

my $module = first { $dir.child($_).e }, |@potential_module
    or die "No file '$module_name.p6' found\n";

require $module <&answer>;

plan 16;

my %cases = from-json $dir.child('cases.json').slurp;

for |%cases<cases> -> %case {
    with %case<expected> {
        is answer(%case<input>), |%case<expected description>
            or diag 'input: ' ~ %case<input>;
    }
    without %case<expected> {
        dies-ok { answer(%case<input>) }, %case<description>
            or diag 'input: ' ~ %case<input>;
    }
}
