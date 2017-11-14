#!/usr/bin/env perl6
use v6;
use Test;
use lib my $dir = $?FILE.IO.dirname;
use JSON::Fast;

my Str:D $exercise := 'AllYourBase';
my Version:D $version = v3;
my Str $module //= $exercise;
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

my $c-data = from-json $=pod.pop.contents;
for $c-data<cases>.values -> $case {
  sub call-convert-base {
    convert-base(
      bases  => %(<from to> Z=> .<input_base output_base>),
      digits => .<input_digits>,
    ) given $case;
  }

  given $case {
    if .<expected><error> {
      throws-like {call-convert-base}, Exception, .<description>;
    }
    else {
      cmp-ok call-convert-base, ‘~~’, |.<expected description>;
    }
  }
}

=head2 Canonical Data
=begin code

{
  "exercise": "all-your-base",
  "version": "2.0.1",
  "comments": [
    "This canonical data makes the following choices:",
    "1. Zero is always represented in outputs as [0] instead of [].",
    "2. In no other instances are leading zeroes present in any outputs.",
    "3. Leading zeroes are accepted in inputs.",
    "4. An empty sequence of input digits is considered zero, rather than an error.",
    "",
    "Tracks that wish to make different decisions for these choices may translate appropriately.",
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
      "expected": [0]
    },
    {
      "description": "single zero",
      "property": "rebase",
      "input_base": 10,
      "input_digits": [0],
      "output_base": 2,
      "expected": [0]
    },
    {
      "description": "multiple zeros",
      "property": "rebase",
      "input_base": 10,
      "input_digits": [0, 0, 0],
      "output_base": 2,
      "expected": [0]
    },
    {
      "description": "leading zeros",
      "property": "rebase",
      "input_base": 7,
      "input_digits": [0, 6, 0],
      "output_base": 10,
      "expected": [4, 2]
    },
    {
      "description": "input base is one",
      "property": "rebase",
      "input_base": 1,
      "input_digits": [],
      "output_base": 10,
      "expected": {"error": "input base must be >= 2"}
    },
    {
      "description": "input base is zero",
      "property": "rebase",
      "input_base": 0,
      "input_digits": [],
      "output_base": 10,
      "expected": {"error": "input base must be >= 2"}
    },
    {
      "description": "input base is negative",
      "property": "rebase",
      "input_base": -2,
      "input_digits": [1],
      "output_base": 10,
      "expected": {"error": "input base must be >= 2"}
    },
    {
      "description": "negative digit",
      "property": "rebase",
      "input_base": 2,
      "input_digits": [1, -1, 1, 0, 1, 0],
      "output_base": 10,
      "expected": {"error": "all digits must satisfy 0 <= d < input base"}
    },
    {
      "description": "invalid positive digit",
      "property": "rebase",
      "input_base": 2,
      "input_digits": [1, 2, 1, 0, 1, 0],
      "output_base": 10,
      "expected": {"error": "all digits must satisfy 0 <= d < input base"}
    },
    {
      "description": "output base is one",
      "property": "rebase",
      "input_base": 2,
      "input_digits": [1, 0, 1, 0, 1, 0],
      "output_base": 1,
      "expected": {"error": "output base must be >= 2"}
    },
    {
      "description": "output base is zero",
      "property": "rebase",
      "input_base": 10,
      "input_digits": [7],
      "output_base": 0,
      "expected": {"error": "output base must be >= 2"}
    },
    {
      "description": "output base is negative",
      "property": "rebase",
      "input_base": 2,
      "input_digits": [1],
      "output_base": -7,
      "expected": {"error": "output base must be >= 2"}
    },
    {
      "description": "both bases are negative",
      "property": "rebase",
      "input_base": -2,
      "input_digits": [1],
      "output_base": -7,
      "expected": {"error": "input base must be >= 2"}
    }
  ]
}

=end code

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
