#!/usr/bin/env perl6
use v6;
use Test;
use JSON::Fast;
use lib $?FILE.IO.dirname;
use RNA;
plan 5;

my Version:D $version = v3;

if RNA.^ver !~~ $version {
  warn "\nExercise version mismatch. Further tests may fail!"
    ~ "\nRNA is {RNA.^ver.gist}. "
    ~ "Test is {$version.gist}.\n";
}

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
