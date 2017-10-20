#!/usr/bin/env perl6
use v6;
use Test;
use lib my $dir = $?FILE.IO.dirname; #`[Look for the module inside the same directory as this test file.]
use JSON::Fast;

my Str:D $exercise := 'HelloWorld'; #`[The name of this exercise.]
my Version:D $version = v2; #`[The version we will be matching against the exercise.]
my Str $module //= $exercise; #`[The name of the module file to be loaded.]
INIT {
  plan 3; #`[This is how many tests we expect to run.]
}

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

#`[Import '&hello' from 'HelloWorld']
require ::($module) <&hello>;

my $c-data;
#`[Go through the cases (hiding at the bottom of this file)
and check that &hello gives us the correct response.]
is hello, |.<expected description> for @($c-data<cases>);

INIT {
$c-data := from-json q:to/END/;

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

END

  if %*ENV<EXERCISM> {
#`[Don't worry about the stuff in here for your exercise.
This is for Exercism folks to check that everything is in order.]
    $module = 'Example';
    if (my $c-data-file =
      "$dir/../../problem-specifications/exercises/{$dir.IO.resolve.basename}/canonical-data.json"
      .IO.resolve) ~~ :f
    {
      is-deeply $c-data, EVAL('from-json $c-data-file.slurp'), 'canonical-data';
    }
    else {
      flunk 'canonical-data';
    }
  }
  else {
    skip;
  }
}
