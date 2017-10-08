#!/usr/bin/env perl6
use v6;
use Test;
use lib my $dir = $?FILE.IO.dirname;
use JSON::Fast;

my Str:D $exercise := 'Phone';
my Version:D $version = v3;
my Str $module //= $exercise;
INIT {
  plan 14;
}

use-ok $module or bail-out;
require ::($module);

if ::($exercise).^ver !~~ $version {
  warn "\nExercise version mismatch. Further tests may fail!"
    ~ "\n$exercise is $(::($exercise).^ver.gist). "
    ~ "Test is $($version.gist).\n";
  bail-out 'Example version must match test version.' if %*ENV<EXERCISM>;
}

require ::($module) <&clean-number>;

my $c-data;
for @($c-data<cases>[0]<cases>) {
  if .<expected> {
    is clean-number(.<phrase>), |.<expected description>;
  } else {
    nok clean-number(.<phrase>), .<description>;
  }
}

done-testing;

INIT {
$c-data := from-json q:to/END/;

{
  "exercise": "phone-number",
  "version": "1.2.0",
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
          "phrase": "(223) 456-7890",
          "expected": "2234567890"
        },
        {
          "description": "cleans numbers with dots",
          "property": "clean",
          "phrase": "223.456.7890",
          "expected": "2234567890"
        },
        {
          "description": "cleans numbers with multiple spaces",
          "property": "clean",
          "phrase": "223 456   7890   ",
          "expected": "2234567890"
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
          "phrase": "22234567890",
          "expected": null
        },
        {
          "description": "valid when 11 digits and starting with 1",
          "property": "clean",
          "phrase": "12234567890",
          "expected": "2234567890"
        },
        {
          "description": "valid when 11 digits and starting with 1 even with punctuation",
          "property": "clean",
          "phrase": "+1 (223) 456-7890",
          "expected": "2234567890"
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
          "description": "invalid if area code does not start with 2-9",
          "property": "clean",
          "phrase": "(123) 456-7890",
          "expected": null
        },
        {
          "description": "invalid if exchange code does not start with 2-9",
          "property": "clean",
          "phrase": "(223) 056-7890",
          "expected": null
        }
      ]
    }
  ]
}

END

  if %*ENV<EXERCISM> {
    $module = 'Example';
    if (my $c-data-file =
      "$dir/../../problem-specifications/exercises/{$dir.IO.resolve.basename}/canonical-data.json"
      .IO.resolve) ~~ :f
    {
      is-deeply $c-data, EVAL('from-json $c-data-file.slurp'), 'canonical-data';
    }
    else {
      flunk 'canonical-data';
    }
  }
  else {
    skip;
  }
}
