#!/usr/bin/env perl6
use v6;
use Test;
use lib my $dir = $?FILE.IO.dirname;
use JSON::Fast;

my Str:D $exercise := 'NucleotideCount';
my Version:D $version = v1;
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

require ::($module) <&nucleotide-count>;

my $c-data = from-json $=pod.pop.contents;
for $c-data<cases>».<cases>».Array.flat {
  if .<expected><error> {
    throws-like {nucleotide-count(.<strand>)}, Exception, .<description>;
  }
  else {
    cmp-ok nucleotide-count(.<strand>), '~~', .<expected>.Bag, .<description>;
  }
}

=head2 Canonical Data
=begin code

{
  "exercise": "nucleotide-count",
  "version": "1.2.0",
  "cases": [
    {
      "description": "count all nucleotides in a strand",
      "cases": [
        {
          "description": "empty strand",
          "property": "nucleotideCounts",
          "strand": "",
          "expected": {
            "A": 0,
            "C": 0,
            "G": 0,
            "T": 0
          }
        },
        {
          "description": "can count one nucleotide in single-character input",
          "property": "nucleotideCounts",
          "strand": "G",
          "expected": {
            "A": 0,
            "C": 0,
            "G": 1,
            "T": 0
          }
        },
        {
          "description": "strand with repeated nucleotide",
          "property": "nucleotideCounts",
          "strand": "GGGGGGG",
          "expected": {
            "A": 0,
            "C": 0,
            "G": 7,
            "T": 0
          }
        },
        {
          "description": "strand with multiple nucleotides",
          "property": "nucleotideCounts",
          "strand": "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC",
          "expected": {
            "A": 20,
            "C": 12,
            "G": 17,
            "T": 21
          }
        },
        {
          "description": "strand with invalid nucleotides",
          "property": "nucleotideCounts",
          "strand": "AGXXACT",
          "expected": {
            "error": "Invalid nucleotide in strand"
          }
        }
      ]
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
