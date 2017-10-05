#!/usr/bin/env perl6
use v6;
use Test;
use lib my $dir = $?FILE.IO.dirname;
use JSON::Fast;

my Str:D $exercise := 'Wordy';
my Version:D $version = v1;
my Str $module //= $exercise;
INIT {
  plan 18;
}

use-ok $module or bail-out;
require ::($module);

if ::($exercise).^ver !~~ $version {
  warn "\nExercise version mismatch. Further tests may fail!"
    ~ "\n$exercise is $(::($exercise).^ver.gist). "
    ~ "Test is $($version.gist).\n";
  bail-out 'Example version must match test version.' if %*ENV<EXERCISM>;
}

require ::($module) <&answer>;

my $c-data;
for @($c-data<cases>) {
  if .<expected> === False {
    throws-like {.<input>.&answer}, Exception, .<description>;
  } else {
    is .<input>.&answer, |.<expected description>;
  }
}

done-testing;

INIT {
$c-data := from-json q:to/END/;

{
  "exercise": "wordy",
  "version": "1.0.0",
  "comments": [
    "The tests that expect 'false' should be implemented to raise",
    "an error, or indicate a failure. Implement this in a way that",
    "makes sense for your language."
  ],
  "cases": [
    {
      "description": "addition",
      "property": "answer",
      "input": "What is 1 plus 1?",
      "expected": 2
    },
    {
      "description": "more addition",
      "property": "answer",
      "input": "What is 53 plus 2?",
      "expected": 55
    },
    {
      "description": "addition with negative numbers",
      "property": "answer",
      "input": "What is -1 plus -10?",
      "expected": -11
    },
    {
      "description": "large addition",
      "property": "answer",
      "input": "What is 123 plus 45678?",
      "expected": 45801
    },
    {
      "description": "subtraction",
      "property": "answer",
      "input": "What is 4 minus -12?",
      "expected": 16
    },
    {
      "description": "multiplication",
      "property": "answer",
      "input": "What is -3 multiplied by 25?",
      "expected": -75
    },
    {
      "description": "division",
      "property": "answer",
      "input": "What is 33 divided by -3?",
      "expected": -11
    },
    {
      "description": "multiple additions",
      "property": "answer",
      "input": "What is 1 plus 1 plus 1?",
      "expected": 3
    },
    {
      "description": "addition and subtraction",
      "property": "answer",
      "input": "What is 1 plus 5 minus -2?",
      "expected": 8
    },
    {
      "description": "multiple subtraction",
      "property": "answer",
      "input": "What is 20 minus 4 minus 13?",
      "expected": 3
    },
    {
      "description": "subtraction then addition",
      "property": "answer",
      "input": "What is 17 minus 6 plus 3?",
      "expected": 14
    },
    {
      "description": "multiple multiplication",
      "property": "answer",
      "input": "What is 2 multiplied by -2 multiplied by 3?",
      "expected": -12
    },
    {
      "description": "addition and multiplication",
      "property": "answer",
      "input": "What is -3 plus 7 multiplied by -2?",
      "expected": -8
    },
    {
      "description": "multiple division",
      "property": "answer",
      "input": "What is -12 divided by 2 divided by -3?",
      "expected": 2
    },
    {
      "description": "unknown operation",
      "property": "answer",
      "input": "What is 52 cubed?",
      "expected": false
    },
    {
      "description": "Non math question",
      "property": "answer",
      "input": "Who is the President of the United States?",
      "expected": false
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
