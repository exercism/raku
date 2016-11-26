#!/usr/bin/env perl6
use v6;
use Test;
use lib IO::Path.new($?FILE).parent.path;

BEGIN {
  plan 8;
  eval-lives-ok %*ENV<EXERCISM>.so ?? 'use Example' !! 'use Leap', 'Module loaded';
}

ok Leap.can('is_leap'), 'Leap class has is_leap() method';

ok my $leap = Leap.new, 'Create new Leap object';

my %year = (
    1996 => True,
    1997 => False,
    1998 => False,
    1900 => False,
    2400 => True,
);

for %year.sort -> $y {
    is $leap.is_leap($y.key), $y.value, 
        [ flat( $y.key, 'is', 'not' xx !$y.value, 'a leap year' ) ].join( ' ' )
}
