#!/usr/bin/env perl6
use v6;
use Test;
use JSON::Fast;
use lib $?FILE.IO.dirname;
use RNA;
plan 5;

my $c-data = from-json $=pod.pop.contents;
is .<input><dna>.&to-rna, |.<expected description> for $c-data<cases>.values;

=head2 Canonical Data
=begin code
{
  "exercise": "rna-transcription",
  "version": "1.2.0",
  "cases": [
    {
      "description": "RNA complement of cytosine is guanine",
      "property": "toRna",
      "input": {
        "dna": "C"
      },
      "expected": "G"
    },
    {
      "description": "RNA complement of guanine is cytosine",
      "property": "toRna",
      "input": {
        "dna": "G"
      },
      "expected": "C"
    },
    {
      "description": "RNA complement of thymine is adenine",
      "property": "toRna",
      "input": {
        "dna": "T"
      },
      "expected": "A"
    },
    {
      "description": "RNA complement of adenine is uracil",
      "property": "toRna",
      "input": {
        "dna": "A"
      },
      "expected": "U"
    },
    {
      "description": "RNA complement",
      "property": "toRna",
      "input": {
        "dna": "ACGTGGTCTTAA"
      },
      "expected": "UGCACCAGAAUU"
    }
  ]
}
=end code
