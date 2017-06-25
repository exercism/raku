#!/usr/bin/env perl6
use v6;
use Test;
use lib my $dir = $?FILE.IO.dirname;

my $exercise = 'Phone';
my $version = v3;
my $module = %*ENV<EXERCISM> ?? 'Example' !! $exercise;
plan 14;

use-ok $module or bail-out;
require ::($module);

if ::($exercise).^ver !~~ $version {
  warn "\nExercise version mismatch. Further tests may fail!"
    ~ "\n$exercise is $(::($exercise).^ver.gist). "
    ~ "Test is $($version.gist).\n";
  bail-out 'Example version must match test version.' if %*ENV<EXERCISM>;
}

require ::($module) <&clean-number>;

my $c-data;
for @($c-data<cases>[0]<cases>) {
  if .<expected> {
    is clean-number(.<phrase>), |.<expected description>;
  } else {
    nok clean-number(.<phrase>), .<description>;
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
      cases       => [
        {
          description => "cleans the number".Str,
          expected    => "2234567890".Str,
          phrase      => "(223) 456-7890".Str,
          property    => "clean".Str,
        },
        {
          description => "cleans numbers with dots".Str,
          expected    => "2234567890".Str,
          phrase      => "223.456.7890".Str,
          property    => "clean".Str,
        },
        {
          description => "cleans numbers with multiple spaces".Str,
          expected    => "2234567890".Str,
          phrase      => "223 456   7890   ".Str,
          property    => "clean".Str,
        },
        {
          description => "invalid when 9 digits".Str,
          expected    => (Any),
          phrase      => "123456789".Str,
          property    => "clean".Str,
        },
        {
          description => "invalid when 11 digits does not start with a 1".Str,
          expected    => (Any),
          phrase      => "22234567890".Str,
          property    => "clean".Str,
        },
        {
          description => "valid when 11 digits and starting with 1".Str,
          expected    => "2234567890".Str,
          phrase      => "12234567890".Str,
          property    => "clean".Str,
        },
        {
          description => "valid when 11 digits and starting with 1 even with punctuation".Str,
          expected    => "2234567890".Str,
          phrase      => "+1 (223) 456-7890".Str,
          property    => "clean".Str,
        },
        {
          description => "invalid when more than 11 digits".Str,
          expected    => (Any),
          phrase      => "321234567890".Str,
          property    => "clean".Str,
        },
        {
          description => "invalid with letters".Str,
          expected    => (Any),
          phrase      => "123-abc-7890".Str,
          property    => "clean".Str,
        },
        {
          description => "invalid with punctuations".Str,
          expected    => (Any),
          phrase      => "123-\@:!-7890".Str,
          property    => "clean".Str,
        },
        {
          description => "invalid if area code does not start with 2-9".Str,
          expected    => (Any),
          phrase      => "(123) 456-7890".Str,
          property    => "clean".Str,
        },
        {
          description => "invalid if exchange code does not start with 2-9".Str,
          expected    => (Any),
          phrase      => "(223) 056-7890".Str,
          property    => "clean".Str,
        },
      ],
      comments    => [
        " Returns the cleaned phone number if given number is valid, ".Str,
        " else returns nil. Note that number is not formatted,       ".Str,
        " just a 10-digit number is returned.                        ".Str,
      ],
      description => "Cleanup user-entered phone numbers".Str,
    },
  ],
  exercise => "phone-number".Str,
  version  => "1.2.0".Str,
} }
