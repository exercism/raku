#!/usr/bin/env perl6

use Test;
use JSON::Tiny;

use lib $?FILE.IO.dirname;

my $module = %*ENV<EXERCISM> ?? 'Example' !! 'SpaceAge';
require ::($module) <&age-on>;

plan 8;

for my @cases -> %case {
        is age-on( |%case<planet seconds>), %case{'expected'},
             %case<planet seconds>.gist;
}

done-testing;

INIT {
  @cases := from-json ｢
    [
      {
        "planet": "Earth",
        "seconds": 1000000000,
        "expected": 31.69
      },
      {
        "planet": "Mercury",
        "seconds": 2134835688,
        "expected": 280.88
      },
      {
        "planet": "Venus",
        "seconds": 189839836,
        "expected": 9.78
      },
      {
        "planet": "Mars",
        "seconds": 2329871239,
        "expected": 39.25
      },
      {
        "planet": "Jupiter",
        "seconds": 901876382,
        "expected": 2.41
      },
      {
        "planet": "Saturn",
        "seconds": 3000000000,
        "expected": 3.23
      },
      {
        "planet": "Uranus",
        "seconds": 3210123456,
        "expected": 1.21
      },
      {
        "planet": "Neptune",
        "seconds": 8210123456,
        "expected": 1.58
      }
    ]
  ｣
}
