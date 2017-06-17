#!/usr/bin/env perl6
use v6;
use Test;
use lib my $dir = $?FILE.IO.dirname;

my $exercise = 'AllYourBase';
my $version = v2;
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

require ::($module) <&convert-base>;

my $c-data;

for @($c-data<cases>) -> $case {
  if $case<expected> ~~ Array:D { test }
  else {
    given $case<description> {
      when 'empty list' { test [] }
      when /base|digit/ { throws-like {call-convert-base}, Exception, $_ }
      when /zero/ {
        when 'leading zeros' { test [4,2] }
        default { test [0] }
      }
      flunk "$_; not tested" if %*ENV<EXERCISM>; # To ensure that no canonical-data cases are missed.
    }
  }

  sub test (Array:D $expected = $case<expected>) {
    is-deeply call-convert-base, $expected, $case<description>
  }

  sub call-convert-base { &::('convert-base')(|$case<input_base input_digits output_base>) }
}

if %*ENV<EXERCISM> {
  if (my $c-data-file = "$dir/../../x-common/exercises/{$dir.IO.resolve.basename}/canonical-data.json".IO.resolve) ~~ :f {
    is-deeply $c-data, EVAL('use JSON::Fast; from-json($c-data-file.slurp);'), 'canonical-data';
  } else { flunk 'canonical-data' }
} else { skip }

done-testing;

INIT { $c-data := {
  cases    => [
    {
      description  => "single bit one to decimal".Str,
      expected     => [
        1.Int,
      ],
      input_base   => 2.Int,
      input_digits => [
        1.Int,
      ],
      output_base  => 10.Int,
      property     => "rebase".Str,
    },
    {
      description  => "binary to single decimal".Str,
      expected     => [
        5.Int,
      ],
      input_base   => 2.Int,
      input_digits => [
        1.Int,
        0.Int,
        1.Int,
      ],
      output_base  => 10.Int,
      property     => "rebase".Str,
    },
    {
      description  => "single decimal to binary".Str,
      expected     => [
        1.Int,
        0.Int,
        1.Int,
      ],
      input_base   => 10.Int,
      input_digits => [
        5.Int,
      ],
      output_base  => 2.Int,
      property     => "rebase".Str,
    },
    {
      description  => "binary to multiple decimal".Str,
      expected     => [
        4.Int,
        2.Int,
      ],
      input_base   => 2.Int,
      input_digits => [
        1.Int,
        0.Int,
        1.Int,
        0.Int,
        1.Int,
        0.Int,
      ],
      output_base  => 10.Int,
      property     => "rebase".Str,
    },
    {
      description  => "decimal to binary".Str,
      expected     => [
        1.Int,
        0.Int,
        1.Int,
        0.Int,
        1.Int,
        0.Int,
      ],
      input_base   => 10.Int,
      input_digits => [
        4.Int,
        2.Int,
      ],
      output_base  => 2.Int,
      property     => "rebase".Str,
    },
    {
      description  => "trinary to hexadecimal".Str,
      expected     => [
        2.Int,
        10.Int,
      ],
      input_base   => 3.Int,
      input_digits => [
        1.Int,
        1.Int,
        2.Int,
        0.Int,
      ],
      output_base  => 16.Int,
      property     => "rebase".Str,
    },
    {
      description  => "hexadecimal to trinary".Str,
      expected     => [
        1.Int,
        1.Int,
        2.Int,
        0.Int,
      ],
      input_base   => 16.Int,
      input_digits => [
        2.Int,
        10.Int,
      ],
      output_base  => 3.Int,
      property     => "rebase".Str,
    },
    {
      description  => "15-bit integer".Str,
      expected     => [
        6.Int,
        10.Int,
        45.Int,
      ],
      input_base   => 97.Int,
      input_digits => [
        3.Int,
        46.Int,
        60.Int,
      ],
      output_base  => 73.Int,
      property     => "rebase".Str,
    },
    {
      description  => "empty list".Str,
      expected     => (Any),
      input_base   => 2.Int,
      input_digits => [ ],
      output_base  => 10.Int,
      property     => "rebase".Str,
    },
    {
      description  => "single zero".Str,
      expected     => (Any),
      input_base   => 10.Int,
      input_digits => [
        0.Int,
      ],
      output_base  => 2.Int,
      property     => "rebase".Str,
    },
    {
      description  => "multiple zeros".Str,
      expected     => (Any),
      input_base   => 10.Int,
      input_digits => [
        0.Int,
        0.Int,
        0.Int,
      ],
      output_base  => 2.Int,
      property     => "rebase".Str,
    },
    {
      description  => "leading zeros".Str,
      expected     => (Any),
      input_base   => 7.Int,
      input_digits => [
        0.Int,
        6.Int,
        0.Int,
      ],
      output_base  => 10.Int,
      property     => "rebase".Str,
    },
    {
      description  => "first base is one".Str,
      expected     => (Any),
      input_base   => 1.Int,
      input_digits => [ ],
      output_base  => 10.Int,
      property     => "rebase".Str,
    },
    {
      description  => "first base is zero".Str,
      expected     => (Any),
      input_base   => 0.Int,
      input_digits => [ ],
      output_base  => 10.Int,
      property     => "rebase".Str,
    },
    {
      description  => "first base is negative".Str,
      expected     => (Any),
      input_base   => -2.Int,
      input_digits => [
        1.Int,
      ],
      output_base  => 10.Int,
      property     => "rebase".Str,
    },
    {
      description  => "negative digit".Str,
      expected     => (Any),
      input_base   => 2.Int,
      input_digits => [
        1.Int,
        -1.Int,
        1.Int,
        0.Int,
        1.Int,
        0.Int,
      ],
      output_base  => 10.Int,
      property     => "rebase".Str,
    },
    {
      description  => "invalid positive digit".Str,
      expected     => (Any),
      input_base   => 2.Int,
      input_digits => [
        1.Int,
        2.Int,
        1.Int,
        0.Int,
        1.Int,
        0.Int,
      ],
      output_base  => 10.Int,
      property     => "rebase".Str,
    },
    {
      description  => "second base is one".Str,
      expected     => (Any),
      input_base   => 2.Int,
      input_digits => [
        1.Int,
        0.Int,
        1.Int,
        0.Int,
        1.Int,
        0.Int,
      ],
      output_base  => 1.Int,
      property     => "rebase".Str,
    },
    {
      description  => "second base is zero".Str,
      expected     => (Any),
      input_base   => 10.Int,
      input_digits => [
        7.Int,
      ],
      output_base  => 0.Int,
      property     => "rebase".Str,
    },
    {
      description  => "second base is negative".Str,
      expected     => (Any),
      input_base   => 2.Int,
      input_digits => [
        1.Int,
      ],
      output_base  => -7.Int,
      property     => "rebase".Str,
    },
    {
      description  => "both bases are negative".Str,
      expected     => (Any),
      input_base   => -2.Int,
      input_digits => [
        1.Int,
      ],
      output_base  => -7.Int,
      property     => "rebase".Str,
    },
  ],
  comments => [
    "It's up to each track do decide:".Str,
    "".Str,
    "1. What's the canonical representation of zero?".Str,
    " - []?".Str,
    " - [0]?".Str,
    "".Str,
    "2. What representations of zero are allowed?".Str,
    " - []?".Str,
    " - [0]?".Str,
    " - [0,0]?".Str,
    "".Str,
    "3. Are leading zeroes allowed?".Str,
    "".Str,
    "4. How should invalid input be handled?".Str,
    "".Str,
    "All the undefined cases are marked as null.".Str,
    "".Str,
    "All your numeric-base are belong to [2..]. :)".Str,
  ],
  exercise => "all-your-base".Str,
  version  => "1.1.0".Str,
} }
