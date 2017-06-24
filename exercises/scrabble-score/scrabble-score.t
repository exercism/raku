#!/usr/bin/env perl6
use v6;
use Test;
use lib my $dir = $?FILE.IO.dirname;

my $exercise = 'Scrabble';
my $version = v1;
my $module = %*ENV<EXERCISM> ?? 'Example' !! $exercise;
plan 13;

use-ok $module or bail-out;
require ::($module);

if ::($exercise).^ver !~~ $version {
  warn "\nExercise version mismatch. Further tests may fail!"
    ~ "\n$exercise is $(::($exercise).^ver.gist). "
    ~ "Test is $($version.gist).\n";
  bail-out 'Example version must match test version.' if %*ENV<EXERCISM>;
}

require ::($module) <&score>;

my $c-data;
is .<input>.&score, |.<expected description> for @($c-data<cases>);

if %*ENV<EXERCISM> {
  if (my $c-data-file = "$dir/../../problem-specifications/exercises/{$dir.IO.resolve.basename}/canonical-data.json".IO.resolve) ~~ :f {
    is-deeply $c-data, EVAL('use JSON::Fast; from-json($c-data-file.slurp);'), 'canonical-data';
  } else { flunk 'canonical-data' }
} else { skip }

done-testing;

INIT { $c-data := {
  cases    => [
    {
      description => "lowercase letter".Str,
      expected    => 1.Int,
      input       => "a".Str,
      property    => "score".Str,
    },
    {
      description => "uppercase letter".Str,
      expected    => 1.Int,
      input       => "A".Str,
      property    => "score".Str,
    },
    {
      description => "valuable letter".Str,
      expected    => 4.Int,
      input       => "f".Str,
      property    => "score".Str,
    },
    {
      description => "short word".Str,
      expected    => 2.Int,
      input       => "at".Str,
      property    => "score".Str,
    },
    {
      description => "short, valuable word".Str,
      expected    => 12.Int,
      input       => "zoo".Str,
      property    => "score".Str,
    },
    {
      description => "medium word".Str,
      expected    => 6.Int,
      input       => "street".Str,
      property    => "score".Str,
    },
    {
      description => "medium, valuable word".Str,
      expected    => 22.Int,
      input       => "quirky".Str,
      property    => "score".Str,
    },
    {
      description => "long, mixed-case word".Str,
      expected    => 41.Int,
      input       => "OxyphenButazone".Str,
      property    => "score".Str,
    },
    {
      description => "english-like word".Str,
      expected    => 8.Int,
      input       => "pinata".Str,
      property    => "score".Str,
    },
    {
      description => "empty input".Str,
      expected    => 0.Int,
      input       => "".Str,
      property    => "score".Str,
    },
    {
      description => "entire alphabet available".Str,
      expected    => 87.Int,
      input       => "abcdefghijklmnopqrstuvwxyz".Str,
      property    => "score".Str,
    },
  ],
  exercise => "scrabble-score".Str,
  version  => "1.0.0".Str,
} }
