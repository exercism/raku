#!/usr/bin/env perl6
use v6;
use Test;
use lib my $dir = $?FILE.IO.dirname;
use JSON::Fast;

my Str:D $exercise := 'Acronym';
my Version:D $version = v1;
my Str $module //= $exercise;
plan 8;

use-ok $module or bail-out;
require ::($module);

if ::($exercise).^ver !~~ $version {
  warn "\nExercise version mismatch. Further tests may fail!"
    ~ "\n$exercise is $(::($exercise).^ver.gist). "
    ~ "Test is $($version.gist).\n";
  bail-out 'Example version must match test version.' if %*ENV<EXERCISM>;
}

require ::($module) <&abbreviate>;

my $c-data = from-json $=pod.pop.contents;

for $c-data<cases>»<cases>».Array.flat {
  is abbreviate(.<phrase>), |.<expected description>;
}

=head2 Canonical Data
=begin code

{
  "exercise": "acronym",
  "version": "1.1.0",
  "cases": [
    {
      "description": "Abbreviate a phrase",
      "cases": [
        {
          "description": "basic",
          "property": "abbreviate",
          "phrase": "Portable Network Graphics",
          "expected": "PNG"
        },
        {
          "description": "lowercase words",
          "property": "abbreviate",
          "phrase": "Ruby on Rails",
          "expected": "ROR"
        },
        {
          "description": "punctuation",
          "property": "abbreviate",
          "phrase": "First In, First Out",
          "expected": "FIFO"
        },
        {
          "description": "all caps words",
          "property": "abbreviate",
          "phrase": "PHP: Hypertext Preprocessor",
          "expected": "PHP"
        },
        {
          "description": "non-acronym all caps word",
          "property": "abbreviate",
          "phrase": "GNU Image Manipulation Program",
          "expected": "GIMP"
        },
        {
          "description": "hyphenated",
          "property": "abbreviate",
          "phrase": "Complementary metal-oxide semiconductor",
          "expected": "CMOS"
        }
      ]
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
