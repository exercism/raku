#!/usr/bin/env perl6
use v6;
use Test;
use JSON::Fast;
use lib $?FILE.IO.dirname;
use NucleotideCount;
plan 5;

my $c-data = from-json $=pod.pop.contents;
for $c-data<cases>».<cases>».Array.flat {
  if .<expected><error> {
    throws-like {nucleotide-count(.<input><strand>)}, Exception, .<description>;
  }
  else {
    cmp-ok nucleotide-count(.<input><strand>), '~~', .<expected>.Bag, .<description>;
  }
}

=head2 Canonical Data
=begin code
{
  "exercise": "nucleotide-count",
  "version": "1.3.0",
  "cases": [
    {
      "description": "count all nucleotides in a strand",
      "cases": [
        {
          "description": "empty strand",
          "property": "nucleotideCounts",
          "input": {
            "strand": ""
          },
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
          "input": {
            "strand": "G"
          },
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
          "input": {
            "strand": "GGGGGGG"
          },
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
          "input": {
            "strand": "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC"
          },
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
          "input": {
            "strand": "AGXXACT"
          },
          "expected": {
            "error": "Invalid nucleotide in strand"
          }
        }
      ]
    }
  ]
}
=end code
