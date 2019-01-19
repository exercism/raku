#!/usr/bin/env perl6
use v6;
use Test;
use JSON::Fast;
use lib $?FILE.IO.dirname;
use Grains;
plan 2;

my $c-data = from-json $=pod.pop.contents;
for $c-data<cases>.values {
  if .<cases> {
    subtest .<description> => {
      plan 10;
      for .<cases>.values {
        .<expected><error>
          ?? throws-like { grains-on-square(.<input><square>) }, Exception, .<description>
          !! is grains-on-square(.<input><square>), |.<expected description> if .<property> eq 'square';
      }
    }
  }
  elsif .<property> eq 'total' {
    is total-grains, |.<expected description>;
  }
}

=head2 Canonical Data
=begin code
{
  "exercise": "grains",
  "version": "1.2.0",
  "comments": [
    "The final tests of square test error conditions",
    "In these cases you should expect an error as is idiomatic for your language"
  ],
  "cases": [
    {
      "description": "returns the number of grains on the square",
      "cases": [
        {
          "description": "1",
          "property": "square",
          "input": {
            "square": 1
          },
          "expected": 1
        },
        {
          "description": "2",
          "property": "square",
          "input": {
            "square": 2
          },
          "expected": 2
        },
        {
          "description": "3",
          "property": "square",
          "input": {
            "square": 3
          },
          "expected": 4
        },
        {
          "description": "4",
          "property": "square",
          "input": {
            "square": 4
          },
          "expected": 8
        },
        {
          "description": "16",
          "property": "square",
          "input": {
            "square": 16
          },
          "expected": 32768
        },
        {
          "description": "32",
          "property": "square",
          "input": {
            "square": 32
          },
          "expected": 2147483648
        },
        {
          "description": "64",
          "property": "square",
          "input": {
            "square": 64
          },
          "expected": 9223372036854775808
        },
        {
          "description": "square 0 raises an exception",
          "property": "square",
          "input": {
            "square": 0
          },
          "expected": {"error": "square must be between 1 and 64"}
        },
        {
          "description": "negative square raises an exception",
          "property": "square",
          "input": {
            "square": -1
          },
          "expected": {"error": "square must be between 1 and 64"}
        },
        {
          "description": "square greater than 64 raises an exception",
          "property": "square",
          "input": {
            "square": 65
          },
          "expected": {"error": "square must be between 1 and 64"}
        }
      ]
    },
    {
      "description": "returns the total number of grains on the board",
      "property": "total",
      "input": {},
      "expected": 18446744073709551615
    }
  ]
}
=end code
