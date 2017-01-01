#!/usr/bin/env perl6
use v6;
use Test;
use lib $?FILE.IO.dirname;

my $exercise = 'AllYourBase';
my $version = v1;
my $module = %*ENV<EXERCISM> ?? 'Example' !! $exercise;
plan 23;

use-ok $module or bail-out;
require ::($module);
if ::($exercise).^ver !~~ $version {
  warn "\nExercise version mismatch. Further tests may fail!"
    ~ "\n$exercise is $(::($exercise).^ver.gist). "
    ~ "Test is $($version.gist).\n";
  bail-out 'Example version must match test version.' if %*ENV<EXERCISM>;
}

my @subs;
BEGIN { @subs = <&convert-base> }
subtest 'Subroutine(s)', {
  plan 1;
  eval-lives-ok "use $module; ::('$_').defined or die '$_ is not defined.'", $_ for @subs;
} or bail-out 'All subroutines must be defined and exported.';
require ::($module) @subs.eager;

is convert-base(|.<input_base input_digits output_base>), |.<expected description> for @(my %cases.<valid>);

my $exception = 'Exception';
for @(%cases<invalid>) {
  $exception = 'X::AllYourBase::Invalid' ~ (.<description> ~~ /«digit»/ ?? 'Digit' !! 'Base') if %*ENV<EXERCISM>;
  throws-like {convert-base |.<input_base input_digits output_base>}, ::($exception), .<description>;
}

done-testing;

INIT {
  require JSON::Tiny <&from-json>;
  %cases := from-json ｢
    {
      "valid":[
        { "description"  : "single bit one to decimal"
        , "input_base"   : 2
        , "input_digits" : [1]
        , "output_base"  : 10
        , "expected"     : [1]
        },
        { "description"  : "binary to single decimal"
        , "input_base"   : 2
        , "input_digits" : [1, 0, 1]
        , "output_base"  : 10
        , "expected"     : [5]
        },
        { "description"  : "single decimal to binary"
        , "input_base"   : 10
        , "input_digits" : [5]
        , "output_base"  : 2
        , "expected"     : [1, 0, 1]
        },
        { "description"  : "binary to multiple decimal"
        , "input_base"   : 2
        , "input_digits" : [1, 0, 1, 0, 1, 0]
        , "output_base"  : 10
        , "expected"     : [4, 2]
        },
        { "description"  : "decimal to binary"
        , "input_base"   : 10
        , "input_digits" : [4, 2]
        , "output_base"  : 2
        , "expected"     : [1, 0, 1, 0, 1, 0]
        },
        { "description"  : "trinary to hexadecimal"
        , "input_base"   : 3
        , "input_digits" : [1, 1, 2, 0]
        , "output_base"  : 16
        , "expected"     : [2, 10]
        },
        { "description"  : "hexadecimal to trinary"
        , "input_base"   : 16
        , "input_digits" : [2, 10]
        , "output_base"  : 3
        , "expected"     : [1, 1, 2, 0]
        },
        { "description"  : "15-bit integer"
        , "input_base"   : 97
        , "input_digits" : [3,46,60]
        , "output_base"  : 73
        , "expected"     : [6,10,45]
        },
        { "description"  : "empty list outputs empty list"
        , "input_base"   : 2
        , "input_digits" : []
        , "output_base"  : 10
        , "expected"     : []
        },
        { "description"  : "single zero outputs 0"
        , "input_base"   : 10
        , "input_digits" : [0]
        , "output_base"  : 2
        , "expected"     : [0]
        },
        { "description"  : "multiple zeros outputs 0"
        , "input_base"   : 10
        , "input_digits" : [0, 0, 0]
        , "output_base"  : 2
        , "expected"     : [0]
        },
        { "description"  : "leading zeros are stripped"
        , "input_base"   : 7
        , "input_digits" : [0, 6, 0]
        , "output_base"  : 10
        , "expected"     : [4, 2]
      } ],
      "invalid":[
        { "description"  : "negative digit is invalid"
        , "input_base"   : 2
        , "input_digits" : [1, -1, 1, 0, 1, 0]
        , "output_base"  : 10
        },
        { "description"  : "invalid positive digit"
        , "input_base"   : 2
        , "input_digits" : [1, 2, 1, 0, 1, 0]
        , "output_base"  : 10
        },
        { "description"  : "first base is one"
        , "input_base"   : 1
        , "input_digits" : []
        , "output_base"  : 10
        },
        { "description"  : "second base is one"
        , "input_base"   : 2
        , "input_digits" : [1, 0, 1, 0, 1, 0]
        , "output_base"  : 1
        },
        { "description"  : "first base is zero"
        , "input_base"   : 0
        , "input_digits" : []
        , "output_base"  : 10
        },
        { "description"  : "second base is zero"
        , "input_base"   : 10
        , "input_digits" : [7]
        , "output_base"  : 0
        },
        { "description"  : "first base is negative"
        , "input_base"   : -2
        , "input_digits" : [1]
        , "output_base"  : 10
        },
        { "description"  : "second base is negative"
        , "input_base"   : 2
        , "input_digits" : [1]
        , "output_base"  : -7
        },
        { "description"  : "both bases are negative"
        , "input_base"   : -2
        , "input_digits" : [1]
        , "output_base"  : -7
      } ]
    }
  ｣
}
