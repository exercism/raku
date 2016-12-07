#!/usr/bin/env perl6

use Test;
use JSON::Tiny;

use lib IO::Path.new($?FILE).parent.path;


my $module = %*ENV<EXERCISM>.so ?? 'Example.pm' !! 'Wordy.pm';

require $module <&answer>;

plan 16;

my %cases = from-json IO::Path.new($?FILE).parent.child('cases.json').slurp;

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
