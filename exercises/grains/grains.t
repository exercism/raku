#!/usr/bin/env perl6
use v6;
use Test;
use lib my $dir = $?FILE.IO.dirname;
use JSON::Tiny;

my $exercise = 'Grains';
my $version = v1;
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

my @subs;
BEGIN { @subs = <&grains-on-square &total-grains> };
subtest 'Subroutine(s)', {
  plan 2;
  eval-lives-ok "use $module; ::('$_').defined or die '$_ is not defined.'", $_ for @subs;
} or bail-out 'All subroutines must be defined and exported.';
require ::($module) @subs.eager;

for @(my $c-data.<cases>.[0].<cases>) {
  if .<expected> == -1 {
    throws-like { grains-on-square(.<input>) }, Exception, .<description>;
  } else {
    is grains-on-square(.<input>), |.<expected description>;
  }
}

is total-grains, |$c-data.<cases>.[1].<expected description>;

if %*ENV<EXERCISM> && (my $c-data-file = "$dir/../../x-common/exercises/{$dir.IO.basename}/canonical-data.json".IO.resolve) ~~ :f {
  is-deeply $c-data, from-json($c-data-file.slurp), 'canonical-data'
} else { skip }

done-testing;

INIT {
  $c-data := from-json ｢
    {
      "exercise": "grains",
      "version": "1.0.0",
      "comments": [
        "The final tests of square test error conditions",
        "The expection for these tests is -1, indicating an error",
        "In these cases you should expect an error as is idiomatic for your language"
      ],
      "cases": [
        {
          "description": "returns the number of grains on the square",
          "cases": [
            {
              "description": "1",
              "property": "square",
              "input": 1,
              "expected": 1
            },
            {
              "description": "2",
              "property": "square",
              "input": 2,
              "expected": 2
            },
            {
              "description": "3",
              "property": "square",
              "input": 3,
              "expected": 4
            },
            {
              "description": "4",
              "property": "square",
              "input": 4,
              "expected": 8
            },
            {
              "description": "16",
              "property": "square",
              "input": 16,
              "expected": 32768
            },
            {
              "description": "32",
              "property": "square",
              "input": 32,
              "expected": 2147483648
            },
            {
              "description": "64",
              "property": "square",
              "input": 64,
              "expected": 9223372036854775808
            },
            {
              "description": "square 0 raises an exception",
              "property": "square",
              "input": 0,
              "expected": -1
            },
            {
              "description": "negative square raises an exception",
              "property": "square",
              "input": -1,
              "expected": -1
            },
            {
              "description": "square greater than 64 raises an exception",
              "property": "square",
              "input": 65,
              "expected": -1
            }
          ]
        },
        {
          "description": "returns the total number of grains on the board",
          "property": "total",
          "expected": 18446744073709551615
        }
      ]
    }
  ｣
}
