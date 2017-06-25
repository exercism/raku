#!/usr/bin/env perl6
use v6;
use Test;
use lib my $dir = $?FILE.IO.dirname;
use JSON::Tiny;

my $exercise = 'WordCount';
my $version = v1;
my $module = %*ENV<EXERCISM> ?? 'Example' !! $exercise;
plan 12;

use-ok $module or bail-out;
require ::($module);

if ::($exercise).^ver !~~ $version {
  warn "\nExercise version mismatch. Further tests may fail!"
    ~ "\n$exercise is $(::($exercise).^ver.gist). "
    ~ "Test is $($version.gist).\n";
  bail-out 'Example version must match test version.' if %*ENV<EXERCISM>;
}

require ::($module) <&count-words>;

my $c-data;
is-deeply (% = .<input>.&count-words), |.<expected description> for @($c-data<cases>);

if %*ENV<EXERCISM> && (my $c-data-file =
  "$dir/../../problem-specifications/exercises/{$dir.IO.resolve.basename}/canonical-data.json".IO.resolve) ~~ :f
{ is-deeply $c-data, from-json($c-data-file.slurp), 'canonical-data' } else { skip }

done-testing;

INIT {
$c-data := from-json q:to/END/;

{
  "exercise": "word-count",
  "version": "1.0.0",
  "comments": [
    "For each word in the input, count the number of times it appears in the",
    "entire sentence."
  ],
  "cases": [
    {
      "description": "count one word",
      "property": "countwords",
      "input": "word",
      "expected": {
        "word": 1
      }
    },
    {
      "description": "count one of each word",
      "property": "countwords",
      "input": "one of each",
      "expected": {
        "one": 1,
        "of": 1,
        "each": 1
      }
    },
    {
      "description": "multiple occurrences of a word",
      "property": "countwords",
      "input": "one fish two fish red fish blue fish",
      "expected": {
        "one": 1,
        "fish": 4,
        "two": 1,
        "red": 1,
        "blue": 1
      }
    },
    {
      "description": "handles cramped lists",
      "property": "countwords",
      "input": "one,two,three",
      "expected": {
        "one": 1,
        "two": 1,
        "three": 1
      }
    },
    {
      "description": "handles expanded lists",
      "property": "countwords",
      "input": "one,\ntwo,\nthree",
      "expected": {
        "one": 1,
        "two": 1,
        "three": 1
      }
    },
    {
      "description": "ignore punctuation",
      "property": "countwords",
      "input": "car: carpet as java: javascript!!&@$%^&",
      "expected": {
        "car": 1,
        "carpet": 1,
        "as": 1,
        "java": 1,
        "javascript": 1
      }
    },
    {
      "description": "include numbers",
      "property": "countwords",
      "input": "testing, 1, 2 testing",
      "expected": {
        "testing": 2,
        "1": 1,
        "2": 1
      }
    },
    {
      "description": "normalize case",
      "property": "countwords",
      "input": "go Go GO Stop stop",
      "expected": {
        "go": 3,
        "stop": 2
      }
    },
    {
      "description": "with apostrophes",
      "property": "countwords",
      "input": "First: don't laugh. Then: don't cry.",
      "expected": {
        "first": 1,
        "don't": 2,
        "laugh": 1,
        "then": 1,
        "cry": 1
      }
    },
    {
      "description": "with quotations",
      "property": "countwords",
      "input": "Joe can't tell between 'large' and large.",
      "expected": {
        "joe": 1,
        "can't": 1,
        "tell": 1,
        "between": 1,
        "large": 2,
        "and": 1
      }
    }
  ]
}

END
}
