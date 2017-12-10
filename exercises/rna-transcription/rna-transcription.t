#!/usr/bin/env perl6
use v6;
use Test;
use lib my $dir = $?FILE.IO.dirname;
use JSON::Fast;

my Str:D $exercise := 'RNA';
my Version:D $version = v2;
my Str $module //= $exercise;
plan 7;

use-ok $module or bail-out;
require ::($module);

if ::($exercise).^ver !~~ $version {
  warn "\nExercise version mismatch. Further tests may fail!"
    ~ "\n$exercise is $(::($exercise).^ver.gist). "
    ~ "Test is $($version.gist).\n";
  bail-out 'Example version must match test version.' if %*ENV<EXERCISM>;
}

require ::($module) <&to-rna>;

my $c-data = from-json $=pod.pop.contents;
is .<dna>.&to-rna, |.<expected description> for $c-data<cases>.values;

=head2 Canonical Data
=begin code

{
  "exercise": "rna-transcription",
  "version": "1.1.0",
  "cases": [
    {
      "description": "RNA complement of cytosine is guanine",
      "property": "toRna",
      "dna": "C",
      "expected": "G"
    },
    {
      "description": "RNA complement of guanine is cytosine",
      "property": "toRna",
      "dna": "G",
      "expected": "C"
    },
    {
      "description": "RNA complement of thymine is adenine",
      "property": "toRna",
      "dna": "T",
      "expected": "A"
    },
    {
      "description": "RNA complement of adenine is uracil",
      "property": "toRna",
      "dna": "A",
      "expected": "U"
    },
    {
      "description": "RNA complement",
      "property": "toRna",
      "dna": "ACGTGGTCTTAA",
      "expected": "UGCACCAGAAUU"
    }
  ]
}

=end code

unless %*ENV<EXERCISM> {
  skip-rest 'exercism tests';
  exit;
}

subtest 'canonical-data' => {
  (my $c-data-file = "$dir/../../problem-specifications/exercises/{
    $dir.IO.resolve.basename
  }/canonical-data.json".IO.resolve) ~~ :f ??
    is-deeply $c-data, EVAL('from-json $c-data-file.slurp'), 'match problem-specifications' !!
    flunk 'problem-specifications file not found';
}

INIT { $module = 'Example' if %*ENV<EXERCISM> }
