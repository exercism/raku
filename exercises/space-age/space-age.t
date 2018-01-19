#!/usr/bin/env perl6
use v6;
use Test;
use JSON::Fast;
use lib $?FILE.IO.dirname;
use SpaceAge;
plan 8;

my Version:D $version = v2;

if SpaceAge.^ver !~~ $version {
  warn "\nExercise version mismatch. Further tests may fail!"
    ~ "\nSpaceAge is {SpaceAge.^ver.gist}. "
    ~ "Test is {$version.gist}.\n";
}

my $c-data = from-json $=pod.pop.contents;
is (age-on ::(.<planet>): .<seconds>), |.<expected description> for @($c-data<cases>);

=head2 Canonical Data
=begin code

{
  "exercise": "space-age",
  "version": "1.0.0",
  "cases": [
    {
      "description": "age on Earth",
      "property": "age",
      "planet": "Earth",
      "seconds": 1000000000,
      "expected": 31.69
    },
    {
      "description": "age on Mercury",
      "property": "age",
      "planet": "Mercury",
      "seconds": 2134835688,
      "expected": 280.88
    },
    {
      "description": "age on Venus",
      "property": "age",
      "planet": "Venus",
      "seconds": 189839836,
      "expected": 9.78
    },
    {
      "description": "age on Mars",
      "property": "age",
      "planet": "Mars",
      "seconds": 2329871239,
      "expected": 39.25
    },
    {
      "description": "age on Jupiter",
      "property": "age",
      "planet": "Jupiter",
      "seconds": 901876382,
      "expected": 2.41
    },
    {
      "description": "age on Saturn",
      "property": "age",
      "planet": "Saturn",
      "seconds": 3000000000,
      "expected": 3.23
    },
    {
      "description": "age on Uranus",
      "property": "age",
      "planet": "Uranus",
      "seconds": 3210123456,
      "expected": 1.21
    },
    {
      "description": "age on Neptune",
      "property": "age",
      "planet": "Neptune",
      "seconds": 8210123456,
      "expected": 1.58
    }
  ]
}

=end code
