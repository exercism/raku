#!/usr/bin/env perl6
use v6;
use Test;
use lib my $dir = $?FILE.IO.dirname;

my $exercise = 'Leap';
my $version = v1;
my $module = %*ENV<EXERCISM> ?? 'Example' !! $exercise;
plan 6;

use-ok $module or bail-out;
require ::($module);

if ::($exercise).^ver !~~ $version {
  warn "\nExercise version mismatch. Further tests may fail!"
    ~ "\n$exercise is $(::($exercise).^ver.gist). "
    ~ "Test is $($version.gist).\n";
  bail-out 'Example version must match test version.' if %*ENV<EXERCISM>;
}

require ::($module) <&is-leap-year>;

my $c-data;
is &::('is-leap-year')(.<input>), |.<expected description> for @($c-data<cases>);

if %*ENV<EXERCISM> {
  if (my $c-data-file = "$dir/../../x-common/exercises/{$dir.IO.resolve.basename}/canonical-data.json".IO.resolve) ~~ :f {
    is-deeply $c-data, EVAL('use JSON::Fast; from-json($c-data-file.slurp);'), 'canonical-data';
  } else { flunk 'canonical-data' }
} else { skip }

done-testing;

INIT { $c-data := {
  cases    => [
    {
      description => "year not divisible by 4: common year".Str,
      expected    => Bool::False.Bool,
      input       => 2015.Int,
      property    => "leapYear".Str,
    },
    {
      description => "year divisible by 4, not divisible by 100: leap year".Str,
      expected    => Bool::True.Bool,
      input       => 2016.Int,
      property    => "leapYear".Str,
    },
    {
      description => "year divisible by 100, not divisible by 400: common year".Str,
      expected    => Bool::False.Bool,
      input       => 2100.Int,
      property    => "leapYear".Str,
    },
    {
      description => "year divisible by 400: leap year".Str,
      expected    => Bool::True.Bool,
      input       => 2000.Int,
      property    => "leapYear".Str,
    },
  ],
  exercise => "leap".Str,
  version  => "1.0.0".Str,
} }
