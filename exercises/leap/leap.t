#!/usr/bin/env perl6
use v6;
use Test;
use lib IO::Path.new($?FILE).parent.path;

my $exercise = 'Leap';
my $version = v1;
my $module = %*ENV<EXERCISM> ?? 'Example' !! $exercise;
plan 6;

use-ok $module or bail-out;
require ::($module);
if ::($exercise).^ver !~~ $version {
  warn "\nExercise version mismatch. Further tests may fail!"
    ~ "\n$exercise is $(::($exercise).^ver.gist). "
    ~ "Test is $($version.gist).\n";
  bail-out 'Example version must match test version.' if %*ENV<EXERCISM>;
}

my @subs;
BEGIN { @subs = <&is-leap-year> };
subtest 'Subroutine(s)', {
  plan 1;
  eval-lives-ok "use $module; ::('$_').defined or die '$_ is not defined.'", $_ for @subs;
} or bail-out 'All subroutines must be defined and exported.';
require ::($module) @subs.eager;

is .<input>.&is-leap-year, |.<expected description> for @(my %c-data.<cases>);

done-testing;

INIT {
  require JSON::Tiny <&from-json>;
  %c-data := from-json ｢
    {
       "cases": [
          {
             "description": "year not divisible by 4: common year",
             "input": 2015,
             "expected": false
          },
          {
             "description": "year divisible by 4, not divisible by 100: leap year",
             "input": 2016,
             "expected": true
          },
          {
             "description": "year divisible by 100, not divisible by 400: common year",
             "input": 2100,
             "expected": false
          },
          {
             "description": "year divisible by 400: leap year",
             "input": 2000,
             "expected": true
          }
       ]
    }
  ｣
}
