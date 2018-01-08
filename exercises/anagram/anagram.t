#!/usr/bin/env perl6
use v6;
use Test;
use lib my $dir = $?FILE.IO.dirname;
use JSON::Fast;

my Str:D $exercise := 'Anagram';
my Version:D $version = v2;
my Str $module //= $exercise;
plan 18;

use-ok $module or bail-out;
require ::($module);

if ::($exercise).^ver !~~ $version {
  warn "\nExercise version mismatch. Further tests may fail!"
    ~ "\n$exercise is $(::($exercise).^ver.gist). "
    ~ "Test is $($version.gist).\n";
  bail-out 'Example version must match test version.' if %*ENV<EXERCISM>;
}

require ::($module) <&match-anagrams>;

my $c-data = from-json $=pod.pop.contents;
cmp-ok match-anagrams( |%(.<input><subject candidates>:p) ), '~~', .<expected>.Set, .<description> for $c-data<cases>.values;

=head2 Canonical Data
=begin code

{
  "exercise": "anagram",
  "version": "1.1.0",
  "comments": [
    "The string argument cases possible matches are passed in as",
    "individual arguments rather than arrays. Languages can include",
    "these string argument cases if passing individual arguments is",
    "idiomatic in that language."
  ],
  "cases": [
    {
      "description": "no matches",
      "property": "anagrams",
      "input": {
        "subject": "diaper",
        "candidates": ["hello", "world", "zombies", "pants"]
      },
      "expected": []
    },
    {
      "description": "detects simple anagram",
      "property": "anagrams",
      "input": {
        "subject": "ant",
        "candidates": ["tan", "stand", "at"]
      },
      "expected": ["tan"]
    },
    {
      "description": "does not detect false positives",
      "property": "anagrams",
      "input": {
        "subject": "galea",
        "candidates": ["eagle"]
      },
      "expected": []
    },
    {
      "description": "detects two anagrams",
      "property": "anagrams",
      "input": {
        "subject": "master",
        "candidates": ["stream", "pigeon", "maters"]
      },
      "expected": ["stream", "maters"]
    },
    {
      "description": "does not detect anagram subsets",
      "property": "anagrams",
      "input": {
        "subject": "good",
        "candidates": ["dog", "goody"]
      },
      "expected": []
    },
    {
      "description": "detects anagram",
      "property": "anagrams",
      "input": {
        "subject": "listen",
        "candidates": ["enlists", "google", "inlets", "banana"]
      },
      "expected": ["inlets"]
    },
    {
      "description": "detects three anagrams",
      "property": "anagrams",
      "input": {
        "subject": "allergy",
        "candidates": [
          "gallery",
          "ballerina",
          "regally",
          "clergy",
          "largely",
          "leading"
        ]
      },
      "expected": ["gallery", "regally", "largely"]
    },
    {
      "description": "does not detect identical words",
      "property": "anagrams",
      "input": {
        "subject": "corn",
        "candidates": ["corn", "dark", "Corn", "rank", "CORN", "cron", "park"]
      },
      "expected": ["cron"]
    },
    {
      "description": "does not detect non-anagrams with identical checksum",
      "property": "anagrams",
      "input": {
        "subject": "mass",
        "candidates": ["last"]
      },
      "expected": []
    },
    {
      "description": "detects anagrams case-insensitively",
      "property": "anagrams",
      "input": {
        "subject": "Orchestra",
        "candidates": ["cashregister", "Carthorse", "radishes"]
      },
      "expected": ["Carthorse"]
    },
    {
      "description": "detects anagrams using case-insensitive subject",
      "property": "anagrams",
      "input": {
        "subject": "Orchestra",
        "candidates": ["cashregister", "carthorse", "radishes"]
      },
      "expected": ["carthorse"]
    },
    {
      "description": "detects anagrams using case-insensitive possible matches",
      "property": "anagrams",
      "input": {
        "subject": "orchestra",
        "candidates": ["cashregister", "Carthorse", "radishes"]
      },
      "expected": ["Carthorse"]
    },
    {
      "description": "does not detect a word as its own anagram",
      "property": "anagrams",
      "input": {
        "subject": "banana",
        "candidates": ["Banana"]
      },
      "expected": []
    },
    {
      "description": "does not detect a anagram if the original word is repeated",
      "property": "anagrams",
      "input": {
        "subject": "go",
        "candidates": ["go Go GO"]
      },
      "expected": []
    },
    {
      "description": "anagrams must use all letters exactly once",
      "property": "anagrams",
      "input": {
        "subject": "tapper",
        "candidates": ["patter"]
      },
      "expected": []
    },
    {
      "description": "capital word is not own anagram",
      "property": "anagrams",
      "input": {
        "subject": "BANANA",
        "candidates": ["Banana"]
      },
      "expected": []
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
