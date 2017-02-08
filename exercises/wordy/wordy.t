#!/usr/bin/env perl6

use Test;
use JSON::Tiny;

use lib $?FILE.IO.dirname;

my $module = %*ENV<EXERCISM> ?? 'Example' !! 'Wordy';
require ::($module) <&answer>;

plan 16;

for my @cases -> %case {
    with %case<expected> {
        is answer(%case<input>), |%case<expected description>
            or diag 'input: ' ~ %case<input>;
    }
    without %case<expected> {
        dies-ok { answer(%case<input>) }, %case<description>
            or diag 'input: ' ~ %case<input>;
    }
}

done-testing;

INIT {
  @cases := from-json ｢
    [
      {
        "description": "addition",
        "input": "What is 1 plus 1?",
        "expected": 2
      },
      {
        "description": "more addition",
        "input": "What is 53 plus 2?",
        "expected": 55
      },
      {
        "description": "addition with negative numbers",
        "input": "What is -1 plus -10?",
        "expected": -11
      },
      {
        "description": "large addition",
        "input": "What is 123 plus 45678?",
        "expected": 45801
      },
      {
        "description": "subtraction",
        "input": "What is 4 minus -12?",
        "expected": 16
      },
      {
        "description": "multiplication",
        "input": "What is -3 multiplied by 25?",
        "expected": -75
      },
      {
        "description": "division",
        "input": "What is 33 divided by -3?",
        "expected": -11
      },
      {
        "description": "multiple additions",
        "input": "What is 1 plus 1 plus 1?",
        "expected": 3
      },
      {
        "description": "addition and subtraction",
        "input": "What is 1 plus 5 minus -2?",
        "expected": 8
      },
      {
        "description": "multiple subtraction",
        "input": "What is 20 minus 4 minus 13?",
        "expected": 3
      },
      {
        "description": "subtraction then addition",
        "input": "What is 17 minus 6 plus 3?",
        "expected": 14
      },
      {
        "description": "multiple multiplication",
        "input": "What is 2 multiplied by -2 multiplied by 3?",
        "expected": -12
      },
      {
        "description": "addition and multiplication",
        "input": "What is -3 plus 7 multiplied by -2?",
        "expected": -8
      },
      {
        "description": "multiple division",
        "input": "What is -12 divided by 2 divided by -3?",
        "expected": 2
      },
      {
        "description": "unknown operation",
        "input": "What is 52 cubed?",
        "expected": null
      },
      {
        "description": "Non math question",
        "input": "Who is the President of the United States?",
        "expected": null
      }
    ]
  ｣
}
