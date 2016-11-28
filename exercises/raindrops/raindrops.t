#!/usr/bin/env perl6
use v6;
use Test;
use lib IO::Path.new($?FILE).parent.path;

BEGIN {
  plan 23;
  eval-lives-ok %*ENV<EXERCISM>.so ?? 'use Example' !! 'use Raindrops', 'Module loaded';
}

ok Raindrops.can('convert'), 'Class Raindrops has convert method';

my @ints = 1, 8, 52;
my @plings = 3, 6, 9, 27;
my @plangs = 5, 10, 25, 3125;
my @plongs = 7, 14, 49;

for @ints {
  is Raindrops.convert($_), $_, "$_ is not a factor of 3, 5 or 7";
  isa-ok Raindrops.convert($_), Str, "$_ gives a string";
}
is Raindrops.convert($_), 'Pling', "$_ is a factor of 3, not 5 or 7" for @plings;
is Raindrops.convert($_), 'Plang', "$_ is a factor of 5, not 3 or 7" for @plangs;
is Raindrops.convert($_), 'Plong', "$_ is a factor of 7, not 3 or 5" for @plongs;
is Raindrops.convert(15), 'PlingPlang', '15 is a factor of 3 and 5, not 7';
is Raindrops.convert(21), 'PlingPlong', '21 is a factor of 3 and 7, not 5';
is Raindrops.convert(35), 'PlangPlong', '35 is a factor of 5 and 7, not 3';
is Raindrops.convert(105), 'PlingPlangPlong', '105 is a factor of 3, 5 and 7';
