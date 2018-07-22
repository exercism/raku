#!/usr/bin/env perl6
use v6;
use Test;
use JSON::Fast;
use lib $?FILE.IO.dirname;
use Luhn;
plan 13;

my $c-data = from-json $=pod.pop.contents;
for $c-data<cases>.values {
  given is-luhn-valid .<input><value> -> $result {
    subtest .<description>, {
      plan 2;
      isa-ok $result, Bool;
      is-deeply $result, .<expected>, 'Result matches expected';
    }
  }
}

=head2 Canonical Data
=begin code
{
  "exercise": "luhn",
  "version": "1.1.0",
  "cases": [
    {
      "description": "single digit strings can not be valid",
      "property": "valid",
      "input": {
        "value": "1"
      },
      "expected": false
    },
    {
      "description": "a single zero is invalid",
      "property": "valid",
      "input": {
        "value": "0"
      },
      "expected": false
    },
    {
      "description": "a simple valid SIN that remains valid if reversed",
      "property": "valid",
      "input": {
        "value": "059"
      },
      "expected": true
    },
    {
      "description": "a simple valid SIN that becomes invalid if reversed",
      "property": "valid",
      "input": {
        "value": "59"
      },
      "expected": true
    },
    {
      "description": "a valid Canadian SIN",
      "property": "valid",
      "input": {
        "value": "055 444 285"
      },
      "expected": true
    },
    {
      "description": "invalid Canadian SIN",
      "property": "valid",
      "input": {
        "value": "055 444 286"
      },
      "expected": false
    },
    {
      "description": "invalid credit card",
      "property": "valid",
      "input": {
        "value": "8273 1232 7352 0569"
      },
      "expected": false
    },
    {
      "description": "valid strings with a non-digit included become invalid",
      "property": "valid",
      "input": {
        "value": "055a 444 285"
      },
      "expected": false
    },
    {
      "description": "valid strings with punctuation included become invalid",
      "property": "valid",
      "input": {
        "value": "055-444-285"
      },
      "expected": false
    },
    {
      "description": "valid strings with symbols included become invalid",
      "property": "valid",
      "input": {
        "value": "055£ 444$ 285"
      },
      "expected": false
    },
    {
      "description": "single zero with space is invalid",
      "property": "valid",
      "input": {
        "value": " 0"
      },
      "expected": false
    },
    {
      "description": "more than a single zero is valid",
      "property": "valid",
      "input": {
        "value": "0000 0"
      },
      "expected": true
    },
    {
      "description": "input digit 9 is correctly converted to output digit 9",
      "property": "valid",
      "input": {
        "value": "091"
      },
      "expected": true
    }
  ]
}
=end code
