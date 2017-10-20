#!/usr/bin/env perl6
use v6;
use Test;
use lib my $dir = $?FILE.IO.dirname;
use JSON::Fast;

my Str:D $exercise := 'Allergies';
my Version:D $version = v2;
my Str $module //= $exercise;
plan 4;

use-ok $module or bail-out;
require ::($module);

if ::($exercise).^ver !~~ $version {
  warn "\nExercise version mismatch. Further tests may fail!"
    ~ "\n$exercise is $(::($exercise).^ver.gist). "
    ~ "Test is $($version.gist).\n";
  bail-out 'Example version must match test version.' if %*ENV<EXERCISM>;
}

require ::($module) <&allergic-to &list-allergies>;

my $c-data;
for $c-data<cases>.values -> %case-set {

  subtest 'allergic-to' => {
    plan 7;
    for %case-set<cases>.values -> %case {
      is allergic-to(%case<score>, .<substance>), .<result>, %case<description> ~ ': ' ~ .<substance> for %case<expected>.values;
    }
  } when %case-set<description> ~~ 'allergicTo';

  subtest 'list-allergies' => {
    plan 9;
    for %case-set<cases>.values {
      cmp-ok list-allergies(.<score>), '~~', .<expected>.Set, .<description>;
    }
  } when %case-set<description> ~~ 'list';

}

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

INIT {
$c-data := from-json q:to/END/;

{
  "exercise": "allergies",
  "version": "1.0.0",
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
          "score": 0,
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
          "score": 1,
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
          "score": 5,
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
          "score": 0,
          "expected": []
        },
        {
          "description": "allergic to just eggs",
          "property": "list",
          "score": 1,
          "expected": ["eggs"]
        },
        {
          "description": "allergic to just peanuts",
          "property": "list",
          "score": 2,
          "expected": ["peanuts"]
        },
        {
          "description": "allergic to just strawberries",
          "property": "list",
          "score": 8,
          "expected": ["strawberries"]
        },
        {
          "description": "allergic to eggs and peanuts",
          "property": "list",
          "score": 3,
          "expected": ["eggs", "peanuts"]
        },
        {
          "description": "allergic to more than eggs but not peanuts",
          "property": "list",
          "score": 5,
          "expected": ["eggs", "shellfish"]
        },
        {
          "description": "allergic to lots of stuff",
          "property": "list",
          "score": 248,
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
          "score": 255,
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
          "score": 509,
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

END

  $module = 'Example' if %*ENV<EXERCISM>;
}
