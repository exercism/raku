#!/usr/bin/env perl6
use v6;
use Test;
use lib IO::Path.new($?FILE).parent.path;

my $exercise = 'Grains';
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
BEGIN { @subs = <&grains-on-square &total-grains> };
subtest 'Subroutine(s)', {
  plan 2;
  eval-lives-ok "use $module; ::('$_').defined or die '$_ is not defined.'", $_ for @subs;
} or bail-out 'All subroutines must be defined and exported.';
require ::($module) @subs.eager;

for @(my %c-data.<square><cases>) {
  if .<expected> == -1 {
    throws-like { grains-on-square(.<input>) }, Exception, .<description>;
  } else {
    is grains-on-square(.<input>), |.<expected description>;
  }
}

is total-grains, |%c-data<total>.<expected description>;

done-testing;

INIT {
  require JSON::Tiny <&from-json>;
  %c-data := from-json ｢
    {
      "#": [
        "The final tests of square test error conditions",
        "The expection for these tests is -1, indicating an error",
        "In these cases you should expect an error as is idiomatic for your language"
      ],
      "square": {
        "description": "returns the number of grains on the square",
        "cases": [
          {
            "description": "1",
            "input": 1,
            "expected": 1
          },
          {
            "description": "2",
            "input": 2,
            "expected": 2
          },
          {
            "description": "3",
            "input": 3,
            "expected": 4
          },
          {
            "description": "4",
            "input": 4,
            "expected": 8
          },
          {
            "description": "16",
            "input": 16,
            "expected": 32768
          },
          {
            "description": "32",
            "input": 32,
            "expected": 2147483648
          },
          {
            "description": "64",
            "input": 64,
            "expected": 9223372036854775808
          },
          {
            "description": "square 0 raises an exception",
            "input": 0,
            "expected": -1
          },
          {
            "description": "negative square raises an exception",
            "input": -1,
            "expected": -1
          },
          {
            "description": "square greater than 64 raises an exception",
            "input": 65,
            "expected": -1
          }
        ]
      },
      "total": {
        "description": "returns the total number of grains on the board",
        "expected": 18446744073709551615
      }
    }
  ｣
}
