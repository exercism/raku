#!/usr/bin/env perl6
use v6;
use Test;
use lib my $dir = $?FILE.IO.dirname; #`[Look for the module inside the same directory as this test file.]
use JSON::Fast;

my Str:D $exercise := 'TwoFer'; #`[The name of this exercise.]
my Version:D $version = v1; #`[The version we will be matching against the exercise.]
my Str $module //= $exercise; #`[The name of the module file to be loaded.]
plan 5; #`[This is how many tests we expect to run.]

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

#`[Import '&two-fer' from 'TwoFer']
require ::($module) <&two-fer>;

my $c-data = from-json $=pod.pop.contents;
# Go through the cases and check that &two-fer gives us the correct response.
for $c-data<cases>.values {
  is .<input> ??
    two-fer(.<input>) !!
    two-fer,
    |.<expected description>;
}

=head2 Canonical Data
=begin code

{
  "exercise": "two-fer",
  "version": "1.1.0",
  "cases": [
    {
      "description": "no name given",
      "property": "name",
      "input": null,
      "expected": "One for you, one for me."
    },
    {
      "description": "a name given",
      "property": "name",
      "input": "Alice",
      "expected": "One for Alice, one for me."
    },
    {
      "description": "another name given",
      "property": "name",
      "input": "Bob",
      "expected": "One for Bob, one for me."
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
