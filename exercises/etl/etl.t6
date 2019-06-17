#!/usr/bin/env perl6
use v6;
use Test;
use JSON::Fast;
use lib $?FILE.IO.dirname;
use ETL;
plan 4;

my $c-data = from-json $=pod.pop.contents;
=head2 Notes
=begin para
The test expects your returned C<Hash> to have
L<type constraints|https://docs.perl6.org/type/Hash#Constraint_value_types>.
Defined C<Str>s for the values, and defined C<Int>s for the keys.
=end para
for $c-data<cases>.values -> %case-set {
  is-deeply(
    transform(Hash[Array[Str:D], Int:D].new(
      .<input>.pairs».&{
        .key.Int => Array[Str:D](.value.Slip)
      }
    )),
    Hash[Int:D, Str:D].new(.<expected>.pairs),
    .<description>
  ) for %case-set<cases>.values;
}

=head2 Canonical Data
=begin code
{
  "exercise": "etl",
  "version": "1.0.0",
  "cases": [
    {
      "comments": [
        "Note:  The expected input data for these tests should have",
        "integer keys (not stringified numbers as shown in the JSON below",
        "Unless the language prohibits that, please implement these tests",
        "such that keys are integers. e.g. in JavaScript, it might look ",
        "like `transform( { 1: ['A'] } );`"
      ],
      "description": "transforms the a set of scrabble data previously indexed by the tile score to a set of data indexed by the tile letter",
      "cases": [
        {
          "description": "a single letter",
          "property": "transform",
          "input": {
            "1": ["A"]
          },
          "expected": {
            "a": 1
          }
        },
        {
          "description": "single score with multiple letters",
          "property": "transform",
          "input": {
            "1": ["A", "E", "I", "O", "U"]
          },
          "expected": {
            "a": 1,
            "e": 1,
            "i": 1,
            "o": 1,
            "u": 1
          }
        },
        {
          "description": "multiple scores with multiple letters",
          "property": "transform",
          "input": {
            "1": ["A", "E"],
            "2": ["D", "G"]
          },
          "expected": {
            "a": 1,
            "d": 2,
            "e": 1,
            "g": 2
          }
        },
        {
          "description": "multiple scores with differing numbers of letters",
          "property": "transform",
          "input": {
             "1": ["A", "E", "I", "O", "U", "L", "N", "R", "S", "T"],
             "2": ["D", "G"],
             "3": ["B", "C", "M", "P"],
             "4": ["F", "H", "V", "W", "Y"],
             "5": ["K"],
             "8": ["J", "X"],
            "10": ["Q", "Z"]
          },
          "expected": {
            "a":  1, "b":  3, "c": 3, "d": 2, "e": 1,
            "f":  4, "g":  2, "h": 4, "i": 1, "j": 8,
            "k":  5, "l":  1, "m": 3, "n": 1, "o": 1,
            "p":  3, "q": 10, "r": 1, "s": 1, "t": 1,
            "u":  1, "v":  4, "w": 4, "x": 8, "y": 4,
            "z": 10
          }
        }
      ]
    }
  ]
}
=end code
