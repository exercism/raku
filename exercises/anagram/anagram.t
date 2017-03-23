#!/usr/bin/env perl6
use v6;
use Test;
use lib my $dir = $?FILE.IO.dirname;
use JSON::Tiny;

my $exercise = 'Anagram';
my $version = v1;
my $module = %*ENV<EXERCISM> ?? 'Example' !! $exercise;
plan 19;

use-ok $module or bail-out;
require ::($module);
if ::($exercise).^ver !~~ $version {
  warn "\nExercise version mismatch. Further tests may fail!"
    ~ "\n$exercise is $(::($exercise).^ver.gist). "
    ~ "Test is $($version.gist).\n";
  bail-out 'Example version must match test version.' if %*ENV<EXERCISM>;
}

my @subs;
BEGIN { @subs = <&match-anagrams> };
subtest 'Subroutine(s)', {
  plan 1;
  eval-lives-ok "use $module; ::('$_').defined or die '$_ is not defined.'", $_ for @subs;
} or bail-out 'All subroutines must be defined and exported.';
require ::($module) @subs.eager;

is match-anagrams(|.<subject candidates>), |.<expected description> for @(my $c-data.<cases>);

if %*ENV<EXERCISM> && (my $c-data-file = "$dir/../../x-common/exercises/{$dir.IO.basename}/canonical-data.json".IO.resolve) ~~ :f {
  is-deeply $c-data, from-json($c-data-file.slurp), 'canonical-data'
} else { skip }

done-testing;

INIT {
  $c-data := from-json ｢
    {
      "exercise": "anagram",
      "version": "1.0.1",
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
          "subject": "diaper",
          "candidates": ["hello", "world", "zombies", "pants"],
          "expected": []
        },
        {
          "description": "detects simple anagram",
          "property": "anagrams",
          "subject": "ant",
          "candidates": ["tan", "stand", "at"],
          "expected": ["tan"]
        },
        {
          "description": "does not detect false positives",
          "property": "anagrams",
          "subject": "galea",
          "candidates": ["eagle"],
          "expected": []
        },
        {
          "description": "detects two anagrams",
          "property": "anagrams",
          "subject": "master",
          "candidates": ["stream", "pigeon", "maters"],
          "expected": ["stream", "maters"]
        },
        {
          "description": "does not detect anagram subsets",
          "property": "anagrams",
          "subject": "good",
          "candidates": ["dog", "goody"],
          "expected": []
        },
        {
          "description": "detects anagram",
          "property": "anagrams",
          "subject": "listen",
          "candidates": ["enlists", "google", "inlets", "banana"],
          "expected": ["inlets"]
        },
        {
          "description": "detects three anagrams",
          "property": "anagrams",
          "subject": "allergy",
          "candidates": [ "gallery",
                          "ballerina",
                          "regally",
                          "clergy",
                          "largely",
                          "leading"
                        ],
          "expected": ["gallery", "regally", "largely"]
        },
        {
          "description": "does not detect identical words",
          "property": "anagrams",
          "subject": "corn",
          "candidates": ["corn", "dark", "Corn", "rank", "CORN", "cron", "park"],
          "expected": ["cron"]
        },
        {
          "description": "does not detect non-anagrams with identical checksum",
          "property": "anagrams",
          "subject": "mass",
          "candidates": ["last"],
          "expected": []
        },
        {
          "description": "detects anagrams case-insensitively",
          "property": "anagrams",
          "subject": "Orchestra",
          "candidates": ["cashregister", "Carthorse", "radishes"],
          "expected": ["Carthorse"]
        },
        {
          "description": "detects anagrams using case-insensitive subject",
          "property": "anagrams",
          "subject": "Orchestra",
          "candidates": ["cashregister", "carthorse", "radishes"],
          "expected": ["carthorse"]
        },
        {
          "description": "detects anagrams using case-insensitive possible matches",
          "property": "anagrams",
          "subject": "orchestra",
          "candidates": ["cashregister", "Carthorse", "radishes"],
          "expected": ["Carthorse"]
        },
        {
          "description": "does not detect a word as its own anagram",
          "property": "anagrams",
          "subject": "banana",
          "candidates": ["Banana"],
          "expected": []
        },
        {
          "description": "does not detect a anagram if the original word is repeated",
          "property": "anagrams",
          "subject": "go",
          "candidates": ["go Go GO"],
          "expected": []
        },
        {
          "description": "anagrams must use all letters exactly once",
          "property": "anagrams",
          "subject": "tapper",
          "candidates": ["patter"],
          "expected": []
        },
        {
          "description": "capital word is not own anagram",
          "property": "anagrams",
          "subject": "BANANA",
          "candidates": ["Banana"],
          "expected": []
        }
      ]
    }
  ｣
}
