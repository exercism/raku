#!/usr/bin/env perl6
use v6;
use Test;
use JSON::Fast;
use lib $?FILE.IO.dirname;
use Hamming;
plan 7;

my $c-data = from-json $=pod.pop.contents;
for $c-data<cases>.values {
  if .<expected><error> {
    throws-like {hamming-distance(|.<input><strand1 strand2>)}, Exception, .<description>;
  } else {
    is hamming-distance(|.<input><strand1 strand2>), |.<expected description>;
  }
}

=head2 Canonical Data
=begin code
{
"exercise": "hamming",
"version": "2.2.0",
  "comments": [
    "Language implementations vary on the issue of unequal length strands.",
    "A language may elect to simplify this task by only presenting equal",
    "length test cases.  For languages handling unequal length strands as",
    "error condition, unequal length test cases are included here and are",
    "indicated with an error object.  Language idioms of errors or exceptions",
    "should be followed.  Alternative interpretations such as ignoring excess",
    "length at the end are not represented here."
  ],
  "cases": [
    {
      "description": "empty strands",
      "property": "distance",
      "input": {
        "strand1": "",
        "strand2": ""
      },
      "expected": 0
    },
    {
      "description": "single letter identical strands",
      "property": "distance",
      "input": {
        "strand1": "A",
        "strand2": "A"
      },
      "expected": 0
    },
    {
      "description": "single letter different strands",
      "property": "distance",
      "input": {
        "strand1": "G",
        "strand2": "T"
      },
      "expected": 1
    },
    {
      "description": "long identical strands",
      "property": "distance",
      "input": {
        "strand1": "GGACTGAAATCTG",
        "strand2": "GGACTGAAATCTG"
      },
      "expected": 0
    },
    {
      "description": "long different strands",
      "property": "distance",
      "input": {
        "strand1": "GGACGGATTCTG",
        "strand2": "AGGACGGATTCT"
      },
      "expected": 9
    },
    {
      "description": "disallow first strand longer",
      "property": "distance",
      "input": {
        "strand1": "AATG",
        "strand2": "AAA"
      },
      "expected": {"error": "left and right strands must be of equal length"}
    },
    {
      "description": "disallow second strand longer",
      "property": "distance",
      "input": {
        "strand1": "ATA",
        "strand2": "AGTG"
      },
      "expected": {"error": "left and right strands must be of equal length"}
    }
  ]
}
=end code
