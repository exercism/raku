#!/usr/bin/env perl6
use v6;
use Test;
use lib my $dir = $?FILE.IO.dirname;

my $exercise = 'Luhn';
my $version = v1;
my $module = %*ENV<EXERCISM> ?? 'Example' !! $exercise;
plan 15;

use-ok $module or bail-out;
require ::($module);

if ::($exercise).^ver !~~ $version {
  warn "\nExercise version mismatch. Further tests may fail!"
    ~ "\n$exercise is $(::($exercise).^ver.gist). "
    ~ "Test is $($version.gist).\n";
  bail-out 'Example version must match test version.' if %*ENV<EXERCISM>;
}

require ::($module) <&is-luhn-valid>;

my $c-data;
is .<input>.&is-luhn-valid, |.<expected description> for @($c-data<cases>);

if %*ENV<EXERCISM> {
  if (my $c-data-file = "$dir/../../problem-specifications/exercises/{$dir.IO.resolve.basename}/canonical-data.json".IO.resolve) ~~ :f {
    is-deeply $c-data, EVAL('use JSON::Fast; from-json($c-data-file.slurp);'), 'canonical-data';
  } else { flunk 'canonical-data' }
} else { skip }

done-testing;

INIT { $c-data := {
  cases    => [
    {
      description => "single digit strings can not be valid".Str,
      expected    => Bool::False.Bool,
      input       => "1".Str,
      property    => "valid".Str,
    },
    {
      description => "A single zero is invalid".Str,
      expected    => Bool::False.Bool,
      input       => "0".Str,
      property    => "valid".Str,
    },
    {
      description => "a simple valid SIN that remains valid if reversed".Str,
      expected    => Bool::True.Bool,
      input       => "059".Str,
      property    => "valid".Str,
    },
    {
      description => "a simple valid SIN that becomes invalid if reversed".Str,
      expected    => Bool::True.Bool,
      input       => "59".Str,
      property    => "valid".Str,
    },
    {
      description => "a valid Canadian SIN".Str,
      expected    => Bool::True.Bool,
      input       => "055 444 285".Str,
      property    => "valid".Str,
    },
    {
      description => "invalid Canadian SIN".Str,
      expected    => Bool::False.Bool,
      input       => "055 444 286".Str,
      property    => "valid".Str,
    },
    {
      description => "invalid credit card".Str,
      expected    => Bool::False.Bool,
      input       => "8273 1232 7352 0569".Str,
      property    => "valid".Str,
    },
    {
      description => "valid strings with a non-digit included become invalid".Str,
      expected    => Bool::False.Bool,
      input       => "055a 444 285".Str,
      property    => "valid".Str,
    },
    {
      description => "valid strings with punctuation included become invalid".Str,
      expected    => Bool::False.Bool,
      input       => "055-444-285".Str,
      property    => "valid".Str,
    },
    {
      description => "valid strings with symbols included become invalid".Str,
      expected    => Bool::False.Bool,
      input       => "055£ 444\$ 285".Str,
      property    => "valid".Str,
    },
    {
      description => "single zero with space is invalid".Str,
      expected    => Bool::False.Bool,
      input       => " 0".Str,
      property    => "valid".Str,
    },
    {
      description => "more than a single zero is valid".Str,
      expected    => Bool::True.Bool,
      input       => "0000 0".Str,
      property    => "valid".Str,
    },
    {
      description => "input digit 9 is correctly converted to output digit 9".Str,
      expected    => Bool::True.Bool,
      input       => "091".Str,
      property    => "valid".Str,
    },
  ],
  exercise => "luhn".Str,
  version  => "1.0.0".Str,
} }
