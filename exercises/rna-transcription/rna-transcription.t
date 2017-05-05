#!/usr/bin/env perl6
use v6;
use Test;
use lib my $dir = $?FILE.IO.dirname;
use JSON::Tiny;

my $exercise = 'RNA';
my $version = v1;
my $module = %*ENV<EXERCISM> ?? 'Example' !! $exercise;
plan 10;

use-ok $module or bail-out;
require ::($module);

if ::($exercise).^ver !~~ $version {
  warn "\nExercise version mismatch. Further tests may fail!"
    ~ "\n$exercise is $(::($exercise).^ver.gist). "
    ~ "Test is $($version.gist).\n";
  bail-out 'Example version must match test version.' if %*ENV<EXERCISM>;
}

require ::($module) <&to-rna>;

my $c-data;
for @($c-data<cases>) {
  if .<expected> {
    is .<dna>.&to-rna, |.<expected description>;
  } else {
    throws-like {.<dna>.&to-rna}, Exception;
  }
}

if %*ENV<EXERCISM> && (my $c-data-file =
  "$dir/../../x-common/exercises/{$dir.IO.resolve.basename}/canonical-data.json".IO.resolve) ~~ :f
{ is-deeply $c-data, from-json($c-data-file.slurp), 'canonical-data' } else { skip }

done-testing;

INIT {
$c-data := from-json q:to/END/;

{
  "exercise": "rna-transcription",
  "version": "1.0.0",
  "comments": [
    "Language implementations vary on the issue of invalid input data.",
    "A language may elect to simplify this task by only presenting valid",
    "test cases.  For languages handling invalid input data as",
    "error conditions, invalid test cases are included here and are",
    "indicated with an expected value of null.  Note however that null is",
    "simply an indication here in the JSON.  Actually returning null from",
    "a rna-transcription function may or may not be idiomatic in a language.",
    "Language idioms of errors or exceptions should be followed.",
    "Alternative interpretations such as ignoring excess length at the end",
    "are not represented here."
  ],
  "cases": [
    {
      "description": "rna complement of cytosine is guanine",
      "property": "toRna",
      "dna": "C",
      "expected": "G"
    },
    {
      "description": "rna complement of guanine is cytosine",
      "property": "toRna",
      "dna": "G",
      "expected": "C"
    },
    {
      "description": "rna complement of thymine is adenine",
      "property": "toRna",
      "dna": "T",
      "expected": "A"
    },
    {
      "description": "rna complement of adenine is uracil",
      "property": "toRna",
      "dna": "A",
      "expected": "U"
    },
    {
      "description": "rna complement",
      "property": "toRna",
      "dna": "ACGTGGTCTTAA",
      "expected": "UGCACCAGAAUU"
    },
    {
      "description": "dna correctly handles invalid input",
      "property": "toRna",
      "dna": "U",
      "expected": null
    },
    {
      "description": "dna correctly handles completely invalid input",
      "property": "toRna",
      "dna": "XXX",
      "expected": null
    },
    {
      "description": "dna correctly handles partially invalid input",
      "property": "toRna",
      "dna": "ACGTXXXCTTAA",
      "expected": null
    }
  ]
}

END
}
