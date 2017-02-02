#!/usr/bin/env perl6
use v6;
use Test;
use lib IO::Path.new($?FILE).parent.path;

my $exercise = 'Bob';
my $version = v1;
my $module = %*ENV<EXERCISM> ?? 'Example' !! $exercise;
plan 27;

use-ok $module or bail-out;
require ::($module);
if ::($exercise).^ver !~~ $version {
  warn "\nExercise version mismatch. Further tests may fail!"
    ~ "\n$exercise is $(::($exercise).^ver.gist). "
    ~ "Test is $($version.gist).\n";
  bail-out 'Example must match test.' if %*ENV<EXERCISM>;
}

subtest 'Class method(s)', {
  plan 1;
  ok ::($exercise).can($_), $_ for <hey>;
}

is ::($exercise).?hey(.<input>), |.<expected description> for my @cases;

done-testing;
 
INIT {
  require JSON::Tiny <&from-json>;
  @cases := from-json ｢
    [
      {
        "description": "stating something",
        "input": "Tom-ay-to, tom-aaaah-to.",
        "expected": "Whatever."
      },
      {
        "description": "shouting",
        "input": "WATCH OUT!",
        "expected": "Whoa, chill out!"
      },
      {
        "description": "shouting gibberish",
        "input": "FCECDFCAAB",
        "expected": "Whoa, chill out!"
      },
      {
        "description": "asking a question",
        "input": "Does this cryogenic chamber make me look fat?",
        "expected": "Sure."
      },
      {
        "description": "asking a numeric question",
        "input": "You are, what, like 15?",
        "expected": "Sure."
      },
      {
        "description": "asking gibberish",
        "input": "fffbbcbeab?",
        "expected": "Sure."
      },
      {
        "description": "talking forcefully",
        "input": "Let's go make out behind the gym!",
        "expected": "Whatever."
      },
      {
        "description": "using acronyms in regular speech",
        "input": "It's OK if you don't want to go to the DMV.",
        "expected": "Whatever."
      },
      {
        "description": "forceful question",
        "input": "WHAT THE HELL WERE YOU THINKING?",
        "expected": "Whoa, chill out!"
      },
      {
        "description": "shouting numbers",
        "input": "1, 2, 3 GO!",
        "expected": "Whoa, chill out!"
      },
      {
        "description": "only numbers",
        "input": "1, 2, 3",
        "expected": "Whatever."
      },
      {
        "description": "question with only numbers",
        "input": "4?",
        "expected": "Sure."
      },
      {
        "description": "shouting with special characters",
        "input": "ZOMG THE %^*@#$(*^ ZOMBIES ARE COMING!!11!!1!",
        "expected": "Whoa, chill out!"
      },
      {
        "description": "shouting with no exclamation mark",
        "input": "I HATE YOU",
        "expected": "Whoa, chill out!"
      },
      {
        "description": "statement containing question mark",
        "input": "Ending with ? means a question.",
        "expected": "Whatever."
      },
      {
        "description": "non-letters with question",
        "input": ":) ?",
        "expected": "Sure."
      },
      {
        "description": "prattling on",
        "input": "Wait! Hang on. Are you going to be OK?",
        "expected": "Sure."
      },
      {
        "description": "silence",
        "input": "",
        "expected": "Fine. Be that way!"
      },
      {
        "description": "prolonged silence",
        "input": "          ",
        "expected": "Fine. Be that way!"
      },
      {
        "description": "alternate silence",
        "input": "\t\t\t\t\t\t\t\t\t\t",
        "expected": "Fine. Be that way!"
      },
      {
        "description": "multiple line question",
        "input": "\nDoes this cryogenic chamber make me look fat?\nno",
        "expected": "Whatever."
      },
      {
        "description": "starting with whitespace",
        "input": "         hmmmmmmm...",
        "expected": "Whatever."
      },
      {
        "description": "ending with whitespace",
        "input": "Okay if like my  spacebar  quite a bit?   ",
        "expected": "Sure."
      },
      {
        "description": "other whitespace",
        "input": "\n\r \t",
        "expected": "Fine. Be that way!"
      },
      {
        "description": "non-question ending with whitespace",
        "input": "This is a statement ending with whitespace      ",
        "expected": "Whatever."
      }
    ]
  ｣
}
