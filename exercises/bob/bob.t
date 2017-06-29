#!/usr/bin/env perl6
use v6;
use Test;
use lib my $dir = $?FILE.IO.dirname; #`[Look for the module inside the same directory as this test file.]
use JSON::Fast;

my $exercise = 'Bob'; #`[The name of this exercise.]
my $version = v1; #`[The version we will be matching against the exercise.]
my $module = %*ENV<EXERCISM> ?? 'Example' !! $exercise; #`[%*ENV<EXERCISM> is for tests not directly for the exercise, don't worry about these :)]
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

my $c-data;
#`[Go through all of the cases (hiding at the bottom of this file)
and check that Bob gives us the correct response for each one.]
is ::($exercise).?hey(.<input>), |.<expected description> for @($c-data<cases>);

#`[Ignore this for your exercise! Tells Exercism folks when exercise cases become out of date.]
if %*ENV<EXERCISM> {
  if (my $c-data-file = "$dir/../../problem-specifications/exercises/{$dir.IO.resolve.basename}/canonical-data.json".IO.resolve) ~~ :f {
    is-deeply $c-data, EVAL('use JSON::Fast; from-json($c-data-file.slurp);'), 'canonical-data';
  } else { flunk 'canonical-data' }
} else { skip }

done-testing; #`[There are no more tests after this :)]

#`['INIT' is a phaser, it makes sure that the test data is available before everything else
starts running (otherwise we'd have to shove the test data into the middle of the file!)]
INIT {
$c-data := from-json q:to/END/;

{
  "exercise": "bob",
  "version": "1.0.0",
  "cases": [
    {
      "description": "stating something",
      "property": "response",
      "input": "Tom-ay-to, tom-aaaah-to.",
      "expected": "Whatever."
    },
    {
      "description": "shouting",
      "property": "response",
      "input": "WATCH OUT!",
      "expected": "Whoa, chill out!"
    },
    {
      "description": "shouting gibberish",
      "property": "response",
      "input": "FCECDFCAAB",
      "expected": "Whoa, chill out!"
    },
    {
      "description": "asking a question",
      "property": "response",
      "input": "Does this cryogenic chamber make me look fat?",
      "expected": "Sure."
    },
    {
      "description": "asking a numeric question",
      "property": "response",
      "input": "You are, what, like 15?",
      "expected": "Sure."
    },
    {
      "description": "asking gibberish",
      "property": "response",
      "input": "fffbbcbeab?",
      "expected": "Sure."
    },
    {
      "description": "talking forcefully",
      "property": "response",
      "input": "Let's go make out behind the gym!",
      "expected": "Whatever."
    },
    {
      "description": "using acronyms in regular speech",
      "property": "response",
      "input": "It's OK if you don't want to go to the DMV.",
      "expected": "Whatever."
    },
    {
      "description": "forceful question",
      "property": "response",
      "input": "WHAT THE HELL WERE YOU THINKING?",
      "expected": "Whoa, chill out!"
    },
    {
      "description": "shouting numbers",
      "property": "response",
      "input": "1, 2, 3 GO!",
      "expected": "Whoa, chill out!"
    },
    {
      "description": "only numbers",
      "property": "response",
      "input": "1, 2, 3",
      "expected": "Whatever."
    },
    {
      "description": "question with only numbers",
      "property": "response",
      "input": "4?",
      "expected": "Sure."
    },
    {
      "description": "shouting with special characters",
      "property": "response",
      "input": "ZOMG THE %^*@#$(*^ ZOMBIES ARE COMING!!11!!1!",
      "expected": "Whoa, chill out!"
    },
    {
      "description": "shouting with no exclamation mark",
      "property": "response",
      "input": "I HATE YOU",
      "expected": "Whoa, chill out!"
    },
    {
      "description": "statement containing question mark",
      "property": "response",
      "input": "Ending with ? means a question.",
      "expected": "Whatever."
    },
    {
      "description": "non-letters with question",
      "property": "response",
      "input": ":) ?",
      "expected": "Sure."
    },
    {
      "description": "prattling on",
      "property": "response",
      "input": "Wait! Hang on. Are you going to be OK?",
      "expected": "Sure."
    },
    {
      "description": "silence",
      "property": "response",
      "input": "",
      "expected": "Fine. Be that way!"
    },
    {
      "description": "prolonged silence",
      "property": "response",
      "input": "          ",
      "expected": "Fine. Be that way!"
    },
    {
      "description": "alternate silence",
      "property": "response",
      "input": "\t\t\t\t\t\t\t\t\t\t",
      "expected": "Fine. Be that way!"
    },
    {
      "description": "multiple line question",
      "property": "response",
      "input": "\nDoes this cryogenic chamber make me look fat?\nno",
      "expected": "Whatever."
    },
    {
      "description": "starting with whitespace",
      "property": "response",
      "input": "         hmmmmmmm...",
      "expected": "Whatever."
    },
    {
      "description": "ending with whitespace",
      "property": "response",
      "input": "Okay if like my  spacebar  quite a bit?   ",
      "expected": "Sure."
    },
    {
      "description": "other whitespace",
      "property": "response",
      "input": "\n\r \t",
      "expected": "Fine. Be that way!"
    },
    {
      "description": "non-question ending with whitespace",
      "property": "response",
      "input": "This is a statement ending with whitespace      ",
      "expected": "Whatever."
    }
  ]
}

END
}
