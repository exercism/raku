#!/usr/bin/env perl6
use v6;
use Test;
use JSON::Fast;
use lib $?FILE.IO.dirname;
use Acronym;
plan 6;

my $c-data = from-json $=pod.pop.contents;

for $c-data<cases>»<cases>»<>.flat {
  is abbreviate(.<input><phrase>), |.<expected description>;
}

=head2 Canonical Data
=begin code
{
  "exercise": "acronym",
  "version": "1.4.0",
  "cases": [
    {
      "description": "Abbreviate a phrase",
      "cases": [
        {
          "description": "basic",
          "property": "abbreviate",
          "input": {
            "phrase": "Portable Network Graphics"
          },
          "expected": "PNG"
        },
        {
          "description": "lowercase words",
          "property": "abbreviate",
          "input": {
            "phrase": "Ruby on Rails"
          },
          "expected": "ROR"
        },
        {
          "description": "punctuation",
          "property": "abbreviate",
          "input": {
            "phrase": "First In, First Out"
          },
          "expected": "FIFO"
        },
        {
          "description": "all caps word",
          "property": "abbreviate",
          "input": {
            "phrase": "GNU Image Manipulation Program"
          },
          "expected": "GIMP"
        },
        {
          "description": "punctuation without whitespace",
          "property": "abbreviate",
          "input": {
            "phrase": "Complementary metal-oxide semiconductor"
          },
          "expected": "CMOS"
        },
        {
          "description": "very long abbreviation",
          "property": "abbreviate",
          "input": {
            "phrase": "Rolling On The Floor Laughing So Hard That My Dogs Came Over And Licked Me"
          },
          "expected": "ROTFLSHTMDCOALM"
        }
      ]
    }
  ]
}
=end code
