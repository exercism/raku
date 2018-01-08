#!/usr/bin/env perl6
use v6;
use Test;
use lib my $dir = $?FILE.IO.dirname; #`[Look for the module inside the same directory as this test file.]
use JSON::Fast;

my Str:D $exercise := 'Bob'; #`[The name of this exercise.]
my Version:D $version = v2; #`[The version we will be matching against the exercise.]
my Str $module //= $exercise; #`[The name of the module file to be loaded.]
plan 28; #`[This is how many tests we expect to run.]

#`[Check that the module can be use-d.]
use-ok $module or bail-out;
require ::($module);

#`[If the exercise is updated, we want to make sure other people testing
your code don't think you've made a mistake if things have changed!]
if ::($exercise).^ver !~~ $version {
  warn "\nExercise version mismatch. Further tests may fail!"
    ~ "\n$exercise is $(::($exercise).^ver.gist). "
    ~ "Test is $($version.gist).\n";
  bail-out 'Example version must match test version.' if %*ENV<EXERCISM>;
}

#`[Check that the class 'Bob' can use all of the methods
needed in the tests (only 'hey' for this one).]
subtest 'Class methods', {
  ok ::($exercise).can($_), $_ for <hey>;
}

my $c-data = from-json $=pod.pop.contents;
# Go through the cases and check that Bob gives us the correct responses.
is ::($exercise).?hey(.<input><heyBob>), |.<expected description> for @($c-data<cases>);

=head2 Canonical Data
=begin code

{
  "exercise": "bob",
  "version": "1.2.0",
  "cases": [
    {
      "description": "stating something",
      "property": "response",
      "input": {
        "heyBob": "Tom-ay-to, tom-aaaah-to."
      },
      "expected": "Whatever."
    },
    {
      "description": "shouting",
      "property": "response",
      "input": {
        "heyBob": "WATCH OUT!"
      },
      "expected": "Whoa, chill out!"
    },
    {
      "description": "shouting gibberish",
      "property": "response",
      "input": {
        "heyBob": "FCECDFCAAB"
      },
      "expected": "Whoa, chill out!"
    },
    {
      "description": "asking a question",
      "property": "response",
      "input": {
        "heyBob": "Does this cryogenic chamber make me look fat?"
      },
      "expected": "Sure."
    },
    {
      "description": "asking a numeric question",
      "property": "response",
      "input": {
        "heyBob": "You are, what, like 15?"
      },
      "expected": "Sure."
    },
    {
      "description": "asking gibberish",
      "property": "response",
      "input": {
        "heyBob": "fffbbcbeab?"
      },
      "expected": "Sure."
    },
    {
      "description": "talking forcefully",
      "property": "response",
      "input": {
        "heyBob": "Let's go make out behind the gym!"
      },
      "expected": "Whatever."
    },
    {
      "description": "using acronyms in regular speech",
      "property": "response",
      "input": {
        "heyBob": "It's OK if you don't want to go to the DMV."
      },
      "expected": "Whatever."
    },
    {
      "description": "forceful question",
      "property": "response",
      "input": {
        "heyBob": "WHAT THE HELL WERE YOU THINKING?"
      },
      "expected": "Calm down, I know what I'm doing!"
    },
    {
      "description": "shouting numbers",
      "property": "response",
      "input": {
        "heyBob": "1, 2, 3 GO!"
      },
      "expected": "Whoa, chill out!"
    },
    {
      "description": "only numbers",
      "property": "response",
      "input": {
        "heyBob": "1, 2, 3"
      },
      "expected": "Whatever."
    },
    {
      "description": "question with only numbers",
      "property": "response",
      "input": {
        "heyBob": "4?"
      },
      "expected": "Sure."
    },
    {
      "description": "shouting with special characters",
      "property": "response",
      "input": {
        "heyBob": "ZOMG THE %^*@#$(*^ ZOMBIES ARE COMING!!11!!1!"
      },
      "expected": "Whoa, chill out!"
    },
    {
      "description": "shouting with no exclamation mark",
      "property": "response",
      "input": {
        "heyBob": "I HATE YOU"
      },
      "expected": "Whoa, chill out!"
    },
    {
      "description": "statement containing question mark",
      "property": "response",
      "input": {
        "heyBob": "Ending with ? means a question."
      },
      "expected": "Whatever."
    },
    {
      "description": "non-letters with question",
      "property": "response",
      "input": {
        "heyBob": ":) ?"
      },
      "expected": "Sure."
    },
    {
      "description": "prattling on",
      "property": "response",
      "input": {
        "heyBob": "Wait! Hang on. Are you going to be OK?"
      },
      "expected": "Sure."
    },
    {
      "description": "silence",
      "property": "response",
      "input": {
        "heyBob": ""
      },
      "expected": "Fine. Be that way!"
    },
    {
      "description": "prolonged silence",
      "property": "response",
      "input": {
        "heyBob": "          "
      },
      "expected": "Fine. Be that way!"
    },
    {
      "description": "alternate silence",
      "property": "response",
      "input": {
        "heyBob": "\t\t\t\t\t\t\t\t\t\t"
      },
      "expected": "Fine. Be that way!"
    },
    {
      "description": "multiple line question",
      "property": "response",
      "input": {
        "heyBob": "\nDoes this cryogenic chamber make me look fat?\nno"
      },
      "expected": "Whatever."
    },
    {
      "description": "starting with whitespace",
      "property": "response",
      "input": {
        "heyBob": "         hmmmmmmm..."
      },
      "expected": "Whatever."
    },
    {
      "description": "ending with whitespace",
      "property": "response",
      "input": {
        "heyBob": "Okay if like my  spacebar  quite a bit?   "
      },
      "expected": "Sure."
    },
    {
      "description": "other whitespace",
      "property": "response",
      "input": {
        "heyBob": "\n\r \t"
      },
      "expected": "Fine. Be that way!"
    },
    {
      "description": "non-question ending with whitespace",
      "property": "response",
      "input": {
        "heyBob": "This is a statement ending with whitespace      "
      },
      "expected": "Whatever."
    }
  ]
}

=end code

#`[Don't worry about the stuff below here for your exercise.
This is for Exercism folks to check that everything is in order.]
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
