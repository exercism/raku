#!/usr/bin/env perl6
use v6;
use Test;
use lib my $dir = $?FILE.IO.dirname; #`[Look for the module inside the same directory as this test file.]

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
INIT { $c-data := {
  cases    => [
    {
      description => "stating something".Str,
      expected    => "Whatever.".Str,
      input       => "Tom-ay-to, tom-aaaah-to.".Str,
      property    => "response".Str,
    },
    {
      description => "shouting".Str,
      expected    => "Whoa, chill out!".Str,
      input       => "WATCH OUT!".Str,
      property    => "response".Str,
    },
    {
      description => "shouting gibberish".Str,
      expected    => "Whoa, chill out!".Str,
      input       => "FCECDFCAAB".Str,
      property    => "response".Str,
    },
    {
      description => "asking a question".Str,
      expected    => "Sure.".Str,
      input       => "Does this cryogenic chamber make me look fat?".Str,
      property    => "response".Str,
    },
    {
      description => "asking a numeric question".Str,
      expected    => "Sure.".Str,
      input       => "You are, what, like 15?".Str,
      property    => "response".Str,
    },
    {
      description => "asking gibberish".Str,
      expected    => "Sure.".Str,
      input       => "fffbbcbeab?".Str,
      property    => "response".Str,
    },
    {
      description => "talking forcefully".Str,
      expected    => "Whatever.".Str,
      input       => "Let's go make out behind the gym!".Str,
      property    => "response".Str,
    },
    {
      description => "using acronyms in regular speech".Str,
      expected    => "Whatever.".Str,
      input       => "It's OK if you don't want to go to the DMV.".Str,
      property    => "response".Str,
    },
    {
      description => "forceful question".Str,
      expected    => "Whoa, chill out!".Str,
      input       => "WHAT THE HELL WERE YOU THINKING?".Str,
      property    => "response".Str,
    },
    {
      description => "shouting numbers".Str,
      expected    => "Whoa, chill out!".Str,
      input       => "1, 2, 3 GO!".Str,
      property    => "response".Str,
    },
    {
      description => "only numbers".Str,
      expected    => "Whatever.".Str,
      input       => "1, 2, 3".Str,
      property    => "response".Str,
    },
    {
      description => "question with only numbers".Str,
      expected    => "Sure.".Str,
      input       => "4?".Str,
      property    => "response".Str,
    },
    {
      description => "shouting with special characters".Str,
      expected    => "Whoa, chill out!".Str,
      input       => "ZOMG THE \%^*\@#\$(*^ ZOMBIES ARE COMING!!11!!1!".Str,
      property    => "response".Str,
    },
    {
      description => "shouting with no exclamation mark".Str,
      expected    => "Whoa, chill out!".Str,
      input       => "I HATE YOU".Str,
      property    => "response".Str,
    },
    {
      description => "statement containing question mark".Str,
      expected    => "Whatever.".Str,
      input       => "Ending with ? means a question.".Str,
      property    => "response".Str,
    },
    {
      description => "non-letters with question".Str,
      expected    => "Sure.".Str,
      input       => ":) ?".Str,
      property    => "response".Str,
    },
    {
      description => "prattling on".Str,
      expected    => "Sure.".Str,
      input       => "Wait! Hang on. Are you going to be OK?".Str,
      property    => "response".Str,
    },
    {
      description => "silence".Str,
      expected    => "Fine. Be that way!".Str,
      input       => "".Str,
      property    => "response".Str,
    },
    {
      description => "prolonged silence".Str,
      expected    => "Fine. Be that way!".Str,
      input       => "          ".Str,
      property    => "response".Str,
    },
    {
      description => "alternate silence".Str,
      expected    => "Fine. Be that way!".Str,
      input       => "\t\t\t\t\t\t\t\t\t\t".Str,
      property    => "response".Str,
    },
    {
      description => "multiple line question".Str,
      expected    => "Whatever.".Str,
      input       => "\nDoes this cryogenic chamber make me look fat?\nno".Str,
      property    => "response".Str,
    },
    {
      description => "starting with whitespace".Str,
      expected    => "Whatever.".Str,
      input       => "         hmmmmmmm...".Str,
      property    => "response".Str,
    },
    {
      description => "ending with whitespace".Str,
      expected    => "Sure.".Str,
      input       => "Okay if like my  spacebar  quite a bit?   ".Str,
      property    => "response".Str,
    },
    {
      description => "other whitespace".Str,
      expected    => "Fine. Be that way!".Str,
      input       => "\n\r \t".Str,
      property    => "response".Str,
    },
    {
      description => "non-question ending with whitespace".Str,
      expected    => "Whatever.".Str,
      input       => "This is a statement ending with whitespace      ".Str,
      property    => "response".Str,
    },
  ],
  exercise => "bob".Str,
  version  => "1.0.0".Str,
} }
