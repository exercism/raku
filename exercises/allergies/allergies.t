#!/usr/bin/env perl6
use v6;
use Test;
use lib my $dir = $?FILE.IO.dirname;

my $exercise = 'Allergies';
my $version = v1;
my $module = %*ENV<EXERCISM> ?? 'Example' !! $exercise;
plan 4;

use-ok $module or bail-out;
require ::($module);

if ::($exercise).^ver !~~ $version {
  warn "\nExercise version mismatch. Further tests may fail!"
    ~ "\n$exercise is $(::($exercise).^ver.gist). "
    ~ "Test is $($version.gist).\n";
  bail-out 'Example version must match test version.' if %*ENV<EXERCISM>;
}

require ::($module) <&allergic-to &list-allergies>;

my $c-data;
for @($c-data<cases>) -> %cases {
  subtest 'allergic-to' => {
    plan 7;
    my @cases = |%cases<cases>;
    for @cases -> %case {
      is allergic-to(%case<score>, .<substance>), .<result>, %case<description> for @(%case<expected>);
    }
  } if %cases<description> ~~ 'allergicTo';
  subtest 'list-allergies' => {
    plan 9;
    my @cases = |%cases<cases>;
    for @cases {
      is list-allergies(.<score>), |.<expected description>;
    }
  } if %cases<description> ~~ 'list';
}

if %*ENV<EXERCISM> {
  if (my $c-data-file = "$dir/../../x-common/exercises/{$dir.IO.resolve.basename}/canonical-data.json".IO.resolve) ~~ :f {
    is-deeply $c-data, EVAL('use JSON::Fast; from-json($c-data-file.slurp);'), 'canonical-data';
  } else { flunk 'canonical-data' }
} else { skip }

done-testing;

INIT { $c-data := {
  cases    => [
    {
      cases       => [
        {
          description => "no allergies means not allergic".Str,
          expected    => [
            {
              result    => Bool::False.Bool,
              substance => "peanuts".Str,
            },
            {
              result    => Bool::False.Bool,
              substance => "cats".Str,
            },
            {
              result    => Bool::False.Bool,
              substance => "strawberries".Str,
            },
          ],
          property    => "allergicTo".Str,
          score       => 0.Int,
        },
        {
          description => "is allergic to eggs".Str,
          expected    => [
            {
              result    => Bool::True.Bool,
              substance => "eggs".Str,
            },
          ],
          property    => "allergicTo".Str,
          score       => 1.Int,
        },
        {
          description => "allergic to eggs in addition to other stuff".Str,
          expected    => [
            {
              result    => Bool::True.Bool,
              substance => "eggs".Str,
            },
            {
              result    => Bool::True.Bool,
              substance => "shellfish".Str,
            },
            {
              result    => Bool::False.Bool,
              substance => "strawberries".Str,
            },
          ],
          property    => "allergicTo".Str,
          score       => 5.Int,
        },
      ],
      comments    => [
        "Given a number and a substance, indicate whether Tom is allergic ".Str,
        "to that substance.".Str,
        "Test cases for this method involve more than one assertion.".Str,
        "Each case in 'expected' specifies what the method should return for".Str,
        "the given substance.".Str,
      ],
      description => "allergicTo".Str,
    },
    {
      cases       => [
        {
          description => "no allergies at all".Str,
          expected    => [ ],
          property    => "list".Str,
          score       => 0.Int,
        },
        {
          description => "allergic to just eggs".Str,
          expected    => [
            "eggs".Str,
          ],
          property    => "list".Str,
          score       => 1.Int,
        },
        {
          description => "allergic to just peanuts".Str,
          expected    => [
            "peanuts".Str,
          ],
          property    => "list".Str,
          score       => 2.Int,
        },
        {
          description => "allergic to just strawberries".Str,
          expected    => [
            "strawberries".Str,
          ],
          property    => "list".Str,
          score       => 8.Int,
        },
        {
          description => "allergic to eggs and peanuts".Str,
          expected    => [
            "eggs".Str,
            "peanuts".Str,
          ],
          property    => "list".Str,
          score       => 3.Int,
        },
        {
          description => "allergic to more than eggs but not peanuts".Str,
          expected    => [
            "eggs".Str,
            "shellfish".Str,
          ],
          property    => "list".Str,
          score       => 5.Int,
        },
        {
          description => "allergic to lots of stuff".Str,
          expected    => [
            "strawberries".Str,
            "tomatoes".Str,
            "chocolate".Str,
            "pollen".Str,
            "cats".Str,
          ],
          property    => "list".Str,
          score       => 248.Int,
        },
        {
          description => "allergic to everything".Str,
          expected    => [
            "eggs".Str,
            "peanuts".Str,
            "shellfish".Str,
            "strawberries".Str,
            "tomatoes".Str,
            "chocolate".Str,
            "pollen".Str,
            "cats".Str,
          ],
          property    => "list".Str,
          score       => 255.Int,
        },
        {
          description => "ignore non allergen score parts".Str,
          expected    => [
            "eggs".Str,
            "shellfish".Str,
            "strawberries".Str,
            "tomatoes".Str,
            "chocolate".Str,
            "pollen".Str,
            "cats".Str,
          ],
          property    => "list".Str,
          score       => 509.Int,
        },
      ],
      comments    => [
        "Given a number, list all things Tom is allergic to".Str,
      ],
      description => "list".Str,
    },
  ],
  exercise => "allergies".Str,
  version  => "1.0.0".Str,
} }
