#!/usr/bin/env perl6
use v6;
use Test;
use lib my $dir = $?FILE.IO.dirname; # Look for the module inside the same directory as this test file.
use JSON::Tiny;

my $exercise = 'HelloWorld'; # The name of this exercise.
my $version = v2; # The version we will be matching against the exercise.
my $module = %*ENV<EXERCISM> ?? 'Example' !! $exercise; # %*ENV<EXERCISM> is for tests not directly for the exercise, don't worry about these :)
plan 4; # This is how many tests we expect to run.

# Check that the module can be use-d.
use-ok $module or bail-out;
require ::($module);

# If the exercise is updated, we want to make sure other people testing
# your code don't think you've made a mistake if things have changed!
if ::($exercise).^ver !~~ $version {
  warn "\nExercise version mismatch. Further tests may fail!"
    ~ "\n$exercise is $(::($exercise).^ver.gist). "
    ~ "Test is $($version.gist).\n";
  bail-out 'Example version must match test version.' if %*ENV<EXERCISM>;
}

# Check that the Module 'HelloWorld' can use all of the subroutines
# needed in the tests (only '&hello' for this one).
my @subs;
BEGIN { @subs = <&hello> };
subtest 'Subroutine(s)', {
  plan 1;
  eval-lives-ok "use $module; ::('$_').defined or die '$_ is not defined.'", $_ for @subs;
} or bail-out 'All subroutines must be defined and exported.';
require ::($module) @subs.eager;

# Go through the cases (hiding at the bottom of this file)
# and check that &hello gives us the correct response.
is hello, |.<expected description> for @(my $c-data.<cases>);

# Ignore this for your exercise! Tells Exercism folks when exercise cases become out of date.
if %*ENV<EXERCISM> && (my $c-data-file = "$dir/../../x-common/exercises/{$dir.IO.basename}/canonical-data.json".IO.resolve) ~~ :f {
  is $c-data, from-json($c-data-file.slurp), 'canonical-data'
} else { skip }

# There are no more tests after this :)
done-testing;

# 'INIT' is a phaser, it makes sure that the test data is available before everything else
# starts running (otherwise we'd have to shove the test data into the middle of the file!)
INIT {
  $c-data := from-json ｢
    {
      "exercise": "hello-world",
      "version": "1.0.0",
      "cases": [
        {
          "description": "Say Hi!",
          "property": "hello",
          "expected": "Hello, World!"
        }
      ]
    }
  ｣
}
