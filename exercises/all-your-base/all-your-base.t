#!/usr/bin/env perl6
use v6;
use Test;
use lib my $dir = $?FILE.IO.dirname;
use JSON::Tiny;

my $exercise = 'AllYourBase';
my $version = v2;
my $module = %*ENV<EXERCISM> ?? 'Example' !! $exercise;
plan 23;

use-ok $module or bail-out;
require ::($module);

if ::($exercise).^ver !~~ $version {
  warn "\nExercise version mismatch. Further tests may fail!"
    ~ "\n$exercise is $(::($exercise).^ver.gist). "
    ~ "Test is $($version.gist).\n";
  bail-out 'Example version must match test version.' if %*ENV<EXERCISM>;
}

require ::($module) <&convert-base>;

my $c-data;
sub test ($case, $expected) { is-deeply &::('convert-base')(|$case<input_base input_digits output_base>), $expected, $case<description> }

for @($c-data<cases>) {
  when .<expected> ~~ Array { test $_, .<expected> }
  when .<description> ~~ /base|digit/ { throws-like {&::('convert-base')(|.<input_base input_digits output_base>)}, Exception, .<description> }
  when .<description> eq 'leading zeros' { test $_, [4,2] }
  when .<description> eq 'empty list' { test $_, [] }
  when .<description> ~~ /zero/ { test $_, [0] }
  default { flunk .<description> } # To ensure that no canonical-data cases are missed.
}

if %*ENV<EXERCISM> && (my $c-data-file =
  "$dir/../../x-common/exercises/{$dir.IO.resolve.basename}/canonical-data.json".IO.resolve) ~~ :f
{ is-deeply $c-data, from-json($c-data-file.slurp), 'canonical-data' } else { skip }

done-testing;

INIT {
$c-data := from-json q:to/END/;

{
  "exercise": "all-your-base",
  "version": "1.1.0",
  "comments": [
    "It's up to each track do decide:",
    "",
    "1. What's the canonical representation of zero?",
    " - []?",
    " - [0]?",
    "",
    "2. What representations of zero are allowed?",
    " - []?",
    " - [0]?",
    " - [0,0]?",
    "",
    "3. Are leading zeroes allowed?",
    "",
    "4. How should invalid input be handled?",
    "",
    "All the undefined cases are marked as null.",
    "",
    "All your numeric-base are belong to [2..]. :)"
  ],
  "cases": [
    {
      "description": "single bit one to decimal",
      "property": "rebase",
      "input_base": 2,
      "input_digits": [1],
      "output_base": 10,
      "expected": [1]
    },
    {
      "description": "binary to single decimal",
      "property": "rebase",
      "input_base": 2,
      "input_digits": [1, 0, 1],
      "output_base": 10,
      "expected": [5]
    },
    {
      "description": "single decimal to binary",
      "property": "rebase",
      "input_base": 10,
      "input_digits": [5],
      "output_base": 2,
      "expected": [1, 0, 1]
    },
    {
      "description": "binary to multiple decimal",
      "property": "rebase",
      "input_base": 2,
      "input_digits": [1, 0, 1, 0, 1, 0],
      "output_base": 10,
      "expected": [4, 2]
    },
    {
      "description": "decimal to binary",
      "property": "rebase",
      "input_base": 10,
      "input_digits": [4, 2],
      "output_base": 2,
      "expected": [1, 0, 1, 0, 1, 0]
    },
    {
      "description": "trinary to hexadecimal",
      "property": "rebase",
      "input_base": 3,
      "input_digits": [1, 1, 2, 0],
      "output_base": 16,
      "expected": [2, 10]
    },
    {
      "description": "hexadecimal to trinary",
      "property": "rebase",
      "input_base": 16,
      "input_digits": [2, 10],
      "output_base": 3,
      "expected": [1, 1, 2, 0]
    },
    {
      "description": "15-bit integer",
      "property": "rebase",
      "input_base": 97,
      "input_digits": [3, 46, 60],
      "output_base": 73,
      "expected": [6, 10, 45]
    },
    {
      "description": "empty list",
      "property": "rebase",
      "input_base": 2,
      "input_digits": [],
      "output_base": 10,
      "expected": null
    },
    {
      "description": "single zero",
      "property": "rebase",
      "input_base": 10,
      "input_digits": [0],
      "output_base": 2,
      "expected": null
    },
    {
      "description": "multiple zeros",
      "property": "rebase",
      "input_base": 10,
      "input_digits": [0, 0, 0],
      "output_base": 2,
      "expected": null
    },
    {
      "description": "leading zeros",
      "property": "rebase",
      "input_base": 7,
      "input_digits": [0, 6, 0],
      "output_base": 10,
      "expected": null
    },
    {
      "description": "first base is one",
      "property": "rebase",
      "input_base": 1,
      "input_digits": [],
      "output_base": 10,
      "expected": null
    },
    {
      "description": "first base is zero",
      "property": "rebase",
      "input_base": 0,
      "input_digits": [],
      "output_base": 10,
      "expected": null
    },
    {
      "description": "first base is negative",
      "property": "rebase",
      "input_base": -2,
      "input_digits": [1],
      "output_base": 10,
      "expected": null
    },
    {
      "description": "negative digit",
      "property": "rebase",
      "input_base": 2,
      "input_digits": [1, -1, 1, 0, 1, 0],
      "output_base": 10,
      "expected": null
    },
    {
      "description": "invalid positive digit",
      "property": "rebase",
      "input_base": 2,
      "input_digits": [1, 2, 1, 0, 1, 0],
      "output_base": 10,
      "expected": null
    },
    {
      "description": "second base is one",
      "property": "rebase",
      "input_base": 2,
      "input_digits": [1, 0, 1, 0, 1, 0],
      "output_base": 1,
      "expected": null
    },
    {
      "description": "second base is zero",
      "property": "rebase",
      "input_base": 10,
      "input_digits": [7],
      "output_base": 0,
      "expected": null
    },
    {
      "description": "second base is negative",
      "property": "rebase",
      "input_base": 2,
      "input_digits": [1],
      "output_base": -7,
      "expected": null
    },
    {
      "description": "both bases are negative",
      "property": "rebase",
      "input_base": -2,
      "input_digits": [1],
      "output_base": -7,
      "expected": null
    }
  ]
}

END
}
