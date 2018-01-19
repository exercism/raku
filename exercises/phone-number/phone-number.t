#!/usr/bin/env perl6
use v6;
use Test;
use JSON::Fast;
use lib $?FILE.IO.dirname;
use Phone;
plan 12;

my Version:D $version = v4;

if Phone.^ver !~~ $version {
  warn "\nExercise version mismatch. Further tests may fail!"
    ~ "\nPhone is {Phone.^ver.gist}. "
    ~ "Test is {$version.gist}.\n";
}

my $c-data = from-json $=pod.pop.contents;
for @($c-data<cases>[0]<cases>) {
  if .<expected> {
    is clean-number(.<phrase>), |.<expected description>;
  } else {
    nok clean-number(.<phrase>), .<description>;
  }
}

=head2 Canonical Data
=begin code

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

=end code
