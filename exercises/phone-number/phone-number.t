#!/usr/bin/env perl6
use v6;
use Test;
use lib my $dir = $?FILE.IO.dirname;
use JSON::Tiny;

my $exercise = 'Phone';
my $version = v1;
my $module = %*ENV<EXERCISM> ?? 'Example' !! $exercise;
plan 13;

use-ok $module or bail-out;
require ::($module);

if ::($exercise).^ver !~~ $version {
  warn "\nExercise version mismatch. Further tests may fail!"
    ~ "\n$exercise is $(::($exercise).^ver.gist). "
    ~ "Test is $($version.gist).\n";
  bail-out 'Example version must match test version.' if %*ENV<EXERCISM>;
}

my @subs;
BEGIN { @subs = <&clean-number> };
subtest 'Subroutine(s)', {
  plan 1;
  eval-lives-ok "use $module; ::('$_').defined or die '$_ is not defined.'", $_ for @subs;
} or bail-out 'All subroutines must be defined and exported.';
require ::($module) @subs.eager;

for @(my $c-data.<cases>.[0].<cases>) {
  if .<expected> {
    is clean-number(.<phrase>), |.<expected description>;
  } else {
    nok clean-number(.<phrase>), .<description>;
  }
}

if %*ENV<EXERCISM> && (my $c-data-file = "$dir/../../x-common/exercises/{$dir.IO.basename}/canonical-data.json".IO.resolve) ~~ :f {
  is-deeply $c-data, from-json($c-data-file.slurp), 'canonical-data'
} else { skip }

done-testing;

INIT {
  $c-data := from-json ｢
    {
      "exercise": "phone-number",
      "version": "1.0.2",
      "cases": [
        {
          "description": "Cleanup user-entered phone numbers",
          "comments": [
            " Returns the cleaned phone number if given number is valid, "
          , " else returns nil. Note that number is not formatted,       "
          , " just a 10-digit number is returned.                        "
          ],
          "cases": [
            {
              "description": "cleans the number",
              "property": "clean",
              "phrase": "(123) 456-7890",
              "expected": "1234567890"
            },
            {
              "description": "cleans numbers with dots",
              "property": "clean",
              "phrase": "123.456.7890",
              "expected": "1234567890"
            },
            {
              "description": "cleans numbers with multiple spaces",
              "property": "clean",
              "phrase": "123 456   7890   ",
              "expected": "1234567890"
            },
            {
              "description": "invalid when 9 digits",
              "property": "clean",
              "phrase": "123456789",
              "expected": null
            },
            {
              "description": "invalid when 11 digits does not start with a 1",
              "property": "clean",
              "phrase": "21234567890",
              "expected": null
            },
            {
              "description": "valid when 11 digits and starting with 1",
              "property": "clean",
              "phrase": "11234567890",
              "expected": "1234567890"
            },
            {
              "description": "invalid when more than 11 digits",
              "property": "clean",
              "phrase": "321234567890",
              "expected": null
            },
            {
              "description": "invalid with letters",
              "property": "clean",
              "phrase": "123-abc-7890",
              "expected": null
            },
            {
              "description": "invalid with punctuations",
              "property": "clean",
              "phrase": "123-@:!-7890",
              "expected": null
            },
            {
              "description": "invalid with right number of digits but letters mixed in",
              "property": "clean",
              "phrase": "1a2b3c4d5e6f7g8h9i0j",
              "expected": null
            }
          ]
        }
      ]
    }
  ｣
}
