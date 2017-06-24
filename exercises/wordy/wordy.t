#!/usr/bin/env perl6
use v6;
use Test;
use lib my $dir = $?FILE.IO.dirname;

my $exercise = 'Wordy';
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

require ::($module) <&answer>;

my $c-data;
for @($c-data<cases>) {
  if .<expected> === False {
    throws-like {.<input>.&answer}, Exception, .<description>;
  } else {
    is .<input>.&answer, |.<expected description>;
  }
}

if %*ENV<EXERCISM> {
  if (my $c-data-file = "$dir/../../problem-specifications/exercises/{$dir.IO.resolve.basename}/canonical-data.json".IO.resolve) ~~ :f {
    is-deeply $c-data, EVAL('use JSON::Fast; from-json($c-data-file.slurp);'), 'canonical-data';
  } else { flunk 'canonical-data' }
} else { skip }

done-testing;

INIT { $c-data := {
  cases    => [
    {
      description => "addition".Str,
      expected    => 2.Int,
      input       => "What is 1 plus 1?".Str,
      property    => "answer".Str,
    },
    {
      description => "more addition".Str,
      expected    => 55.Int,
      input       => "What is 53 plus 2?".Str,
      property    => "answer".Str,
    },
    {
      description => "addition with negative numbers".Str,
      expected    => -11.Int,
      input       => "What is -1 plus -10?".Str,
      property    => "answer".Str,
    },
    {
      description => "large addition".Str,
      expected    => 45801.Int,
      input       => "What is 123 plus 45678?".Str,
      property    => "answer".Str,
    },
    {
      description => "subtraction".Str,
      expected    => 16.Int,
      input       => "What is 4 minus -12?".Str,
      property    => "answer".Str,
    },
    {
      description => "multiplication".Str,
      expected    => -75.Int,
      input       => "What is -3 multiplied by 25?".Str,
      property    => "answer".Str,
    },
    {
      description => "division".Str,
      expected    => -11.Int,
      input       => "What is 33 divided by -3?".Str,
      property    => "answer".Str,
    },
    {
      description => "multiple additions".Str,
      expected    => 3.Int,
      input       => "What is 1 plus 1 plus 1?".Str,
      property    => "answer".Str,
    },
    {
      description => "addition and subtraction".Str,
      expected    => 8.Int,
      input       => "What is 1 plus 5 minus -2?".Str,
      property    => "answer".Str,
    },
    {
      description => "multiple subtraction".Str,
      expected    => 3.Int,
      input       => "What is 20 minus 4 minus 13?".Str,
      property    => "answer".Str,
    },
    {
      description => "subtraction then addition".Str,
      expected    => 14.Int,
      input       => "What is 17 minus 6 plus 3?".Str,
      property    => "answer".Str,
    },
    {
      description => "multiple multiplication".Str,
      expected    => -12.Int,
      input       => "What is 2 multiplied by -2 multiplied by 3?".Str,
      property    => "answer".Str,
    },
    {
      description => "addition and multiplication".Str,
      expected    => -8.Int,
      input       => "What is -3 plus 7 multiplied by -2?".Str,
      property    => "answer".Str,
    },
    {
      description => "multiple division".Str,
      expected    => 2.Int,
      input       => "What is -12 divided by 2 divided by -3?".Str,
      property    => "answer".Str,
    },
    {
      description => "unknown operation".Str,
      expected    => Bool::False.Bool,
      input       => "What is 52 cubed?".Str,
      property    => "answer".Str,
    },
    {
      description => "Non math question".Str,
      expected    => Bool::False.Bool,
      input       => "Who is the President of the United States?".Str,
      property    => "answer".Str,
    },
  ],
  comments => [
    "The tests that expect 'false' should be implemented to raise".Str,
    "an error, or indicate a failure. Implement this in a way that".Str,
    "makes sense for your language.".Str,
  ],
  exercise => "wordy".Str,
  version  => "1.0.0".Str,
} }
