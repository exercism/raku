#!/usr/bin/env perl6
use v6;
use Test;
use lib my $dir = $?FILE.IO.dirname;
use JSON::Tiny;

my $exercise = 'SpaceAge';
my $version = v1;
my $module = %*ENV<EXERCISM> ?? 'Example' !! $exercise;
plan 11;

use-ok $module or bail-out;
require ::($module);

if ::($exercise).^ver !~~ $version {
  warn "\nExercise version mismatch. Further tests may fail!"
    ~ "\n$exercise is $(::($exercise).^ver.gist). "
    ~ "Test is $($version.gist).\n";
  bail-out 'Example version must match test version.' if %*ENV<EXERCISM>;
}

my @classes;
BEGIN { @classes = <Mercury Venus Earth Mars Jupiter Saturn Uranus Neptune> };
subtest 'Class(es)', {
  plan 8;
  eval-lives-ok "use $module; ::('$_').new or die 'Could not call .new on $_\.'", $_ for @classes;
} or bail-out 'All classes must be defined and exported.';
require ::($module) @classes.eager;

is (age-on ::(.<planet>): .<seconds>), |.<expected description> for @(my $c-data.<cases>);

if %*ENV<EXERCISM> && (my $c-data-file = "$dir/../../x-common/exercises/{$dir.IO.basename}/canonical-data.json".IO.resolve) ~~ :f {
  is-deeply $c-data, from-json($c-data-file.slurp), 'canonical-data'
} else { skip }

done-testing;

INIT {
  $c-data := from-json ｢
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
  ｣
}
