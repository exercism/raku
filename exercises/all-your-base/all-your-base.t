#!/usr/bin/env perl6

use Test;
use lib IO::Path.new($?FILE).parent.path;

plan 21;

my $module = %*ENV<EXERCISM>.so ?? 'Example.pm' !! 'AllYourBase.pm';

require $module <&convert-base>;

sub testcase( %test ) {

    if %test<error>:exists {
        dies-ok {
            convert-base( %test<input_digits>, %test<input_base>, %test<output_base> )
        }, %test<description>;
    }
    else {
        my $r = convert-base( %test<input_digits>, %test<input_base>, %test<output_base> );

        is-deeply $r, %test<output_digits>, %test<description>;
    }
}

testcase($_) for 
        { "description"  => "single bit one to decimal"
        , "input_base"   => 2
        , "input_digits" => [1]
        , "output_base"  => 10
        , "output_digits"=> [1]
        },
        { "description"  => "binary to single decimal"
        , "input_base"   => 2
        , "input_digits" => [1, 0, 1]
        , "output_base"  => 10
        , "output_digits"=> [5]
        },
        { "description"  => "single decimal to binary"
        , "input_base"   => 10
        , "input_digits" => [5]
        , "output_base"  => 2
        , "output_digits"=> [1, 0, 1]
        },
        { "description"  => "binary to multiple decimal"
        , "input_base"   => 2
        , "input_digits" => [1, 0, 1, 0, 1, 0]
        , "output_base"  => 10
        , "output_digits"=> [4, 2]
        },
        { "description"  => "decimal to binary"
        , "input_base"   => 10
        , "input_digits" => [4, 2]
        , "output_base"  => 2
        , "output_digits"=> [1, 0, 1, 0, 1, 0]
        },
        { "description"  => "trinary to hexadecimal"
        , "input_base"   => 3
        , "input_digits" => [1, 1, 2, 0]
        , "output_base"  => 16
        , "output_digits"=> [2, 10]
        },
        { "description"  => "hexadecimal to trinary"
        , "input_base"   => 16
        , "input_digits" => [2, 10]
        , "output_base"  => 3
        , "output_digits"=> [1, 1, 2, 0]
        },
        { "description"  => "15-bit integer"
        , "input_base"   => 97
        , "input_digits" => [3,46,60]
        , "output_base"  => 73
        , "output_digits"=> [6,10,45]
        },
        { "description"  => "empty list"
        , "input_base"   => 2
        , "input_digits" => []
        , "output_base"  => 10
        , "output_digits"=> [0]
        },
        { "description"  => "single zero"
        , "input_base"   => 10
        , "input_digits" => [0]
        , "output_base"  => 2
        , "output_digits"=> [0]
        },
        { "description"  => "multiple zeros"
        , "input_base"   => 10
        , "input_digits" => [0, 0, 0]
        , "output_base"  => 2
        , "output_digits"=> [0]
        },
        { "description"  => "leading zeros"
        , "input_base"   => 7
        , "input_digits" => [0, 6, 0]
        , "output_base"  => 10
        , "output_digits"=> [ 4, 2 ]
        },
        { "description"  => "negative digit"
        , "input_base"   => 2
        , "input_digits" => [1, -1, 1, 0, 1, 0]
        , "output_base"  => 10
        , "output_digits"=> Nil
        , error => rx:s/negative digit not allowed/
        },
        { "description"  => "invalid positive digit"
        , "input_base"   => 2
        , "input_digits" => [1, 2, 1, 0, 1, 0]
        , "output_base"  => 10
        , "output_digits"=> Nil
        , error => rx:s/digit equal of greater than the base/
        },
        { "description"  => "first base is one"
        , "input_base"   => 1
        , "input_digits" => []
        , "output_base"  => 10
        , "output_digits"=> Nil
        , error => rx:s/base must be greater than 1/
        },
        { "description"  => "second base is one"
        , "input_base"   => 2
        , "input_digits" => [1, 0, 1, 0, 1, 0]
        , "output_base"  => 1
        , "output_digits"=> Nil
        , error => rx:s/base must be greater than 1/
        },
        { "description"  => "first base is zero"
        , "input_base"   => 0
        , "input_digits" => []
        , "output_base"  => 10
        , "output_digits"=> Nil
        , error => rx:s/base must be greater than 1/
        },
        { "description"  => "second base is zero"
        , "input_base"   => 10
        , "input_digits" => [7]
        , "output_base"  => 0
        , "output_digits"=> Nil
        , error => rx:s/base must be greater than 1/
        },
        { "description"  => "first base is negative"
        , "input_base"   => -2
        , "input_digits" => [1]
        , "output_base"  => 10
        , "output_digits"=> Nil
        , error => rx:s/base must be greater than 1/
        },
        { "description"  => "second base is negative"
        , "input_base"   => 2
        , "input_digits" => [1]
        , "output_base"  => -7
        , "output_digits"=> Nil
        , error => rx:s/base must be greater than 1/
        },
        { "description"  => "both bases are negative"
        , "input_base"   => -2
        , "input_digits" => [1]
        , "output_base"  => -7
        , "output_digits"=> Nil
        , error => rx:s/base must be greater than 1/
        };
