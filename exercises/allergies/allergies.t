#!/usr/bin/env perl6
use v6;
use Test;
use JSON::Fast;
use lib $?FILE.IO.dirname;
use Allergies;
plan 2;

my Version:D $version = v4;

if Allergies.^ver !~~ $version {
  warn "\nExercise version mismatch. Further tests may fail!"
    ~ "\nAllergies is {Allergies.^ver.gist}. "
    ~ "Test is {$version.gist}.\n";
}

my $c-data = from-json $=pod.pop.contents;
for $c-data<cases>.values -> %case-set {

  subtest 'allergic-to' => {
    plan 7;
    for %case-set<cases>.values -> %case {
      for %case<expected>.values {
        given allergic-to %case<input><score>, .<substance> -> $result {
          subtest %case<description> ~ ': ' ~ .<substance> => {
            plan 2;
            isa-ok $result, Bool;
            is-deeply $result, .<result>, 'Result matches expected';
          }
        }
      }
    }
  } when %case-set<description> ~~ 'allergicTo';

  subtest 'list-allergies' => {
    plan 9;
    for %case-set<cases>.values {
      cmp-ok list-allergies(.<input><score>), '~~', .<expected>.Set, .<description>;
    }
  } when %case-set<description> ~~ 'list';

}

=head2 Canonical Data
=begin code

{
  "exercise": "allergies",
  "version": "1.1.0",
  "cases": [
    {
      "description": "allergicTo",
      "comments": [
        "Given a number and a substance, indicate whether Tom is allergic ",
        "to that substance.",
        "Test cases for this method involve more than one assertion.",
        "Each case in 'expected' specifies what the method should return for",
        "the given substance."
      ],
      "cases": [
        {
          "description": "no allergies means not allergic",
          "property": "allergicTo",
          "input": {
            "score": 0
          },
          "expected": [
            {
              "substance": "peanuts",
              "result": false
            },
            {
              "substance": "cats",
              "result": false
            },
            {
              "substance": "strawberries",
              "result": false
            }
          ]
        },
        {
          "description": "is allergic to eggs",
          "property": "allergicTo",
          "input": {
            "score": 1
          },
          "expected": [
            {
              "substance": "eggs",
              "result": true
            }
          ]
        },
        {
          "description": "allergic to eggs in addition to other stuff",
          "property": "allergicTo",
          "input": {
            "score": 5
          },
          "expected": [
            {
              "substance": "eggs",
              "result": true
            },
            {
              "substance": "shellfish",
              "result": true
            },
            {
              "substance": "strawberries",
              "result": false
            }
          ]
        }
      ]
    },
    {
      "description": "list",
      "comments": [
        "Given a number, list all things Tom is allergic to"
      ],
      "cases": [
        {
          "description": "no allergies at all",
          "property": "list",
          "input": {
            "score": 0
          },
          "expected": []
        },
        {
          "description": "allergic to just eggs",
          "property": "list",
          "input": {
            "score": 1
          },
          "expected": ["eggs"]
        },
        {
          "description": "allergic to just peanuts",
          "property": "list",
          "input": {
            "score": 2
          },
          "expected": ["peanuts"]
        },
        {
          "description": "allergic to just strawberries",
          "property": "list",
          "input": {
            "score": 8
          },
          "expected": ["strawberries"]
        },
        {
          "description": "allergic to eggs and peanuts",
          "property": "list",
          "input": {
            "score": 3
          },
          "expected": ["eggs", "peanuts"]
        },
        {
          "description": "allergic to more than eggs but not peanuts",
          "property": "list",
          "input": {
            "score": 5
          },
          "expected": ["eggs", "shellfish"]
        },
        {
          "description": "allergic to lots of stuff",
          "property": "list",
          "input": {
            "score": 248
          },
          "expected": [ "strawberries",
                        "tomatoes",
                        "chocolate",
                        "pollen",
                        "cats"
                      ]
        },
        {
          "description": "allergic to everything",
          "property": "list",
          "input": {
            "score": 255
          },
          "expected": [ "eggs",
                        "peanuts",
                        "shellfish",
                        "strawberries",
                        "tomatoes",
                        "chocolate",
                        "pollen",
                        "cats"
                      ]
        },
        {
          "description": "ignore non allergen score parts",
          "property": "list",
          "input": {
            "score": 509
          },
          "expected": [ "eggs",
                        "shellfish",
                        "strawberries",
                        "tomatoes",
                        "chocolate",
                        "pollen",
                        "cats"
                      ]
        }
      ]
    }
  ]
}

=end code
