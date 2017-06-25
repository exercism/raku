#!/usr/bin/env perl6
use v6;
use Test;
use lib my $dir = $?FILE.IO.dirname;
use JSON::Tiny;

my $exercise = 'FlattenArray';
my $version = v1;
my $module = %*ENV<EXERCISM> ?? 'Example' !! $exercise;
plan 8;

use-ok $module or bail-out;
require ::($module);

if ::($exercise).^ver !~~ $version {
  warn "\nExercise version mismatch. Further tests may fail!"
    ~ "\n$exercise is $(::($exercise).^ver.gist). "
    ~ "Test is $($version.gist).\n";
  bail-out 'Example version must match test version.' if %*ENV<EXERCISM>;
}

require ::($module) <&flatten-array>;

my $c-data;
is-deeply &::('flatten-array')(.<input>), |.<expected description> for @($c-data<cases>);

if %*ENV<EXERCISM> && (my $c-data-file =
  "$dir/../../problem-specifications/exercises/{$dir.IO.resolve.basename}/canonical-data.json".IO.resolve) ~~ :f
{ is-deeply $c-data, from-json($c-data-file.slurp), 'canonical-data' } else { skip }

done-testing;

INIT {
$c-data := from-json q:to/END/;

{
  "exercise": "flatten-array",
  "version": "1.1.0",
  "cases": [
    {
      "description": "no nesting",
      "property": "flatten",
      "input": [0, 1, 2],
      "expected": [0, 1, 2]
    },
    {
      "description": "flattens array with just integers present",
      "property": "flatten",
      "input": [1, [2, 3, 4, 5, 6, 7], 8],
      "expected": [1, 2, 3, 4, 5, 6, 7, 8]
    },
    {
      "description": "5 level nesting",
      "property": "flatten",
      "input": [0, 2, [[2, 3], 8, 100, 4, [[[50]]]], -2],
      "expected": [0, 2, 2, 3, 8, 100, 4, 50, -2]
    },
    {
      "description": "6 level nesting",
      "property": "flatten",
      "input": [1, [2, [[3]], [4, [[5]]], 6, 7], 8],
      "expected": [1, 2, 3, 4, 5, 6, 7, 8]
    },
    {
      "description": "6 level nest list with null values",
      "property": "flatten",
      "input": [0, 2, [[2, 3], 8, [[100]], null, [[null]]], -2],
      "expected": [0, 2, 2, 3, 8, 100, -2]
    },
    {
      "description": "all values in nested list are null",
      "property": "flatten",
      "input": [null, [[[null]]], null, null, [[null, null], null], null],
      "expected": []
    }
  ]
}

END
}
