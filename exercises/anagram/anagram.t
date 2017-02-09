#!/usr/bin/env perl6
use v6;
use Test;
use lib IO::Path.new($?FILE).parent.path;

my $exercise = 'Anagram';
my $version = v1;
my $module = %*ENV<EXERCISM> ?? 'Example' !! $exercise;
plan 18;

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

is match-anagrams(|.<subject candidates>), |.<expected description> for @(my %c-data.<cases>);

done-testing;

INIT {
  require JSON::Tiny <&from-json>;
  %c-data := from-json ｢
    {
        "#": [
            "The string argument cases possible matches are passed in as",
            "individual arguments rather than arrays. Languages can include",
            "these string argument cases if passing individual arguments is",
            "idiomatic in that language.",
            "Some tests have a \"comment\" property, which provides more",
            "information that could be added to the test case as a code comment."
        ],
        "cases": [
            {
                "description": "no matches",
                "subject": "diaper",
                "candidates": [ "hello", "world", "zombies", "pants"],
                "expected": []
            },
            {
                "description": "detects simple anagram",
                "subject": "ant",
                "candidates": ["tan", "stand", "at"],
                "expected": ["tan"]
            },
            {
                "description": "does not detect false positives",
                "subject": "galea",
                "candidates": ["eagle"],
                "expected": []
            },
            {
                "description": "detects multiple anagrams",
                "subject": "master",
                "candidates": ["stream", "pigeon", "maters"],
                "expected": ["stream", "maters"]
            },
            {
                "description": "does not detect anagram subsets",
                "subject": "good",
                "candidates": ["dog", "goody"],
                "expected": []
            },
            {
                "description": "detects anagram",
                "subject": "listen",
                "candidates": ["enlists", "google", "inlets", "banana"],
                "expected": ["inlets"]
            },
            {
                "description": "detects multiple anagrams",
                "subject": "allergy",
                "candidates": ["gallery", "ballerina", "regally", "clergy", "largely", "leading"],
                "expected": ["gallery", "regally", "largely"]
            },
            {
                "description": "does not detect identical words",
                "subject": "corn",
                "candidates": ["corn", "dark", "Corn", "rank", "CORN", "cron", "park"],
                "expected": ["cron"]
            },  
            {
                "description": "does not detect non-anagrams with identical checksum",
                "subject": "mass",
                "candidates": ["last"],
                "expected": []
            },
            {
                "description": "detects anagrams case-insensitively",
                "subject": "Orchestra",
                "candidates": ["cashregister", "Carthorse", "radishes"],
                "expected": ["Carthorse"]
            },
            {
                "description": "detects anagrams using case-insensitive subject",
                "subject": "Orchestra",
                "candidates": ["cashregister", "carthorse", "radishes"],
                "expected": ["carthorse"]
            },
            {
                "description": "detects anagrams using case-insensitive possible matches",
                "subject": "orchestra",
                "candidates": ["cashregister", "Carthorse", "radishes"],
                "expected": ["Carthorse"]
            },
            {
                "description": "does not detect a word as its own anagram",
                "subject": "banana",
                "candidates": ["Banana"],
                "expected": []
            },
            {
                "description": "does not detect a anagram if the original word is repeated",
                "subject": "go",
                "candidates": ["go Go GO"],
                "expected": []
            },
            {
                "description": "anagrams must use all letters exactly once",
                "subject": "tapper",
                "candidates": ["patter"],
                "expected": []
            },
            {
                "description": "capital word is not own anagram",
                "subject": "BANANA",
                "candidates": ["Banana"],
                "expected": []
            }
        ]
    }
  ｣ 
}
