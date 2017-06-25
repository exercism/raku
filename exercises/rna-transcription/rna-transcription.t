#!/usr/bin/env perl6
use v6;
use Test;
use lib my $dir = $?FILE.IO.dirname;

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

if %*ENV<EXERCISM> {
  if (my $c-data-file = "$dir/../../problem-specifications/exercises/{$dir.IO.resolve.basename}/canonical-data.json".IO.resolve) ~~ :f {
    is-deeply $c-data, EVAL('use JSON::Fast; from-json($c-data-file.slurp);'), 'canonical-data';
  } else { flunk 'canonical-data' }
} else { skip }

done-testing;

INIT { $c-data := {
  cases    => [
    {
      description => "RNA complement of cytosine is guanine".Str,
      dna         => "C".Str,
      expected    => "G".Str,
      property    => "toRna".Str,
    },
    {
      description => "RNA complement of guanine is cytosine".Str,
      dna         => "G".Str,
      expected    => "C".Str,
      property    => "toRna".Str,
    },
    {
      description => "RNA complement of thymine is adenine".Str,
      dna         => "T".Str,
      expected    => "A".Str,
      property    => "toRna".Str,
    },
    {
      description => "RNA complement of adenine is uracil".Str,
      dna         => "A".Str,
      expected    => "U".Str,
      property    => "toRna".Str,
    },
    {
      description => "RNA complement".Str,
      dna         => "ACGTGGTCTTAA".Str,
      expected    => "UGCACCAGAAUU".Str,
      property    => "toRna".Str,
    },
    {
      description => "correctly handles invalid input (RNA instead of DNA)".Str,
      dna         => "U".Str,
      expected    => (Any),
      property    => "toRna".Str,
    },
    {
      description => "correctly handles completely invalid DNA input".Str,
      dna         => "XXX".Str,
      expected    => (Any),
      property    => "toRna".Str,
    },
    {
      description => "correctly handles partially invalid DNA input".Str,
      dna         => "ACGTXXXCTTAA".Str,
      expected    => (Any),
      property    => "toRna".Str,
    },
  ],
  comments => [
    "Language implementations vary on the issue of invalid input data.".Str,
    "A language may elect to simplify this task by only presenting valid".Str,
    "test cases.  For languages handling invalid input data as".Str,
    "error conditions, invalid test cases are included here and are".Str,
    "indicated with an expected value of null.  Note however that null is".Str,
    "simply an indication here in the JSON.  Actually returning null from".Str,
    "a rna-transcription function may or may not be idiomatic in a language.".Str,
    "Language idioms of errors or exceptions should be followed.".Str,
    "Alternative interpretations such as ignoring excess length at the end".Str,
    "are not represented here.".Str,
  ],
  exercise => "rna-transcription".Str,
  version  => "1.0.1".Str,
} }
