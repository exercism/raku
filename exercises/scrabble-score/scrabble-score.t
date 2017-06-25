#!/usr/bin/env perl6
use v6;
use Test;
use lib my $dir = $?FILE.IO.dirname;
use JSON::Tiny;

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

if %*ENV<EXERCISM> && (my $c-data-file =
  "$dir/../../problem-specifications/exercises/{$dir.IO.resolve.basename}/canonical-data.json".IO.resolve) ~~ :f
{ is-deeply $c-data, from-json($c-data-file.slurp), 'canonical-data' } else { skip }

done-testing;

INIT {
$c-data := from-json q:to/END/;

{
  "exercise": "scrabble-score",
  "version": "1.0.0",
  "cases": [
    {
      "description": "lowercase letter",
      "property": "score",
      "input": "a",
      "expected": 1
    },
    {
      "description": "uppercase letter",
      "property": "score",
      "input": "A",
      "expected": 1
    },
    {
      "description": "valuable letter",
      "property": "score",
      "input": "f",
      "expected": 4
    },
    {
      "description": "short word",
      "property": "score",
      "input": "at",
      "expected": 2
    },
    {
      "description": "short, valuable word",
      "property": "score",
      "input": "zoo",
      "expected": 12
    },
    {
      "description": "medium word",
      "property": "score",
      "input": "street",
      "expected": 6
    },
    {
      "description": "medium, valuable word",
      "property": "score",
      "input": "quirky",
      "expected": 22
    },
    {
      "description": "long, mixed-case word",
      "property": "score",
      "input": "OxyphenButazone",
      "expected": 41
    },
    {
      "description": "english-like word",
      "property": "score",
      "input": "pinata",
      "expected": 8
    },
    {
      "description": "empty input",
      "property": "score",
      "input": "",
      "expected": 0
    },
    {
      "description": "entire alphabet available",
      "property": "score",
      "input": "abcdefghijklmnopqrstuvwxyz",
      "expected": 87
    }
  ]
}

END
}
