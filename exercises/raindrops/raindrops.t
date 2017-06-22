#!/usr/bin/env perl6
use v6;
use Test;
use lib my $dir = $?FILE.IO.dirname;

my $exercise = 'Raindrops';
my $version = v1;
my $module = %*ENV<EXERCISM> ?? 'Example' !! $exercise;
plan 20;

use-ok $module or bail-out;
require ::($module);

if ::($exercise).^ver !~~ $version {
  warn "\nExercise version mismatch. Further tests may fail!"
    ~ "\n$exercise is $(::($exercise).^ver.gist). "
    ~ "Test is $($version.gist).\n";
  bail-out 'Example version must match test version.' if %*ENV<EXERCISM>;
}

require ::($module) <&convert>;

my $c-data;
for @($c-data<cases>) {
  subtest {
    plan 2;
    is .<number>.&convert, |.<expected description>;
    isa-ok .<number>.&convert, Str;
  }
}

if %*ENV<EXERCISM> {
  if (my $c-data-file = "$dir/../../x-common/exercises/{$dir.IO.resolve.basename}/canonical-data.json".IO.resolve) ~~ :f {
    is-deeply $c-data, EVAL('use JSON::Fast; from-json($c-data-file.slurp);'), 'canonical-data';
  } else { flunk 'canonical-data' }
} else { skip }

done-testing;

INIT { $c-data := {
  cases    => [
    {
      description => "the sound for 1 is 1".Str,
      expected    => "1".Str,
      number      => 1.Int,
      property    => "convert".Str,
    },
    {
      description => "the sound for 3 is Pling".Str,
      expected    => "Pling".Str,
      number      => 3.Int,
      property    => "convert".Str,
    },
    {
      description => "the sound for 5 is Plang".Str,
      expected    => "Plang".Str,
      number      => 5.Int,
      property    => "convert".Str,
    },
    {
      description => "the sound for 7 is Plong".Str,
      expected    => "Plong".Str,
      number      => 7.Int,
      property    => "convert".Str,
    },
    {
      description => "the sound for 6 is Pling as it has a factor 3".Str,
      expected    => "Pling".Str,
      number      => 6.Int,
      property    => "convert".Str,
    },
    {
      description => "2 to the power 3 does not make a raindrop sound as 3 is the exponent not the base".Str,
      expected    => "8".Str,
      number      => 8.Int,
      property    => "convert".Str,
    },
    {
      description => "the sound for 9 is Pling as it has a factor 3".Str,
      expected    => "Pling".Str,
      number      => 9.Int,
      property    => "convert".Str,
    },
    {
      description => "the sound for 10 is Plang as it has a factor 5".Str,
      expected    => "Plang".Str,
      number      => 10.Int,
      property    => "convert".Str,
    },
    {
      description => "the sound for 14 is Plong as it has a factor of 7".Str,
      expected    => "Plong".Str,
      number      => 14.Int,
      property    => "convert".Str,
    },
    {
      description => "the sound for 15 is PlingPlang as it has factors 3 and 5".Str,
      expected    => "PlingPlang".Str,
      number      => 15.Int,
      property    => "convert".Str,
    },
    {
      description => "the sound for 21 is PlingPlong as it has factors 3 and 7".Str,
      expected    => "PlingPlong".Str,
      number      => 21.Int,
      property    => "convert".Str,
    },
    {
      description => "the sound for 25 is Plang as it has a factor 5".Str,
      expected    => "Plang".Str,
      number      => 25.Int,
      property    => "convert".Str,
    },
    {
      description => "the sound for 27 is Pling as it has a factor 3".Str,
      expected    => "Pling".Str,
      number      => 27.Int,
      property    => "convert".Str,
    },
    {
      description => "the sound for 35 is PlangPlong as it has factors 5 and 7".Str,
      expected    => "PlangPlong".Str,
      number      => 35.Int,
      property    => "convert".Str,
    },
    {
      description => "the sound for 49 is Plong as it has a factor 7".Str,
      expected    => "Plong".Str,
      number      => 49.Int,
      property    => "convert".Str,
    },
    {
      description => "the sound for 52 is 52".Str,
      expected    => "52".Str,
      number      => 52.Int,
      property    => "convert".Str,
    },
    {
      description => "the sound for 105 is PlingPlangPlong as it has factors 3, 5 and 7".Str,
      expected    => "PlingPlangPlong".Str,
      number      => 105.Int,
      property    => "convert".Str,
    },
    {
      description => "the sound for 3125 is Plang as it has a factor 5".Str,
      expected    => "Plang".Str,
      number      => 3125.Int,
      property    => "convert".Str,
    },
  ],
  exercise => "raindrops".Str,
  version  => "1.0.0".Str,
} }
