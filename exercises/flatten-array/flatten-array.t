#!/usr/bin/env perl6
use v6;
use Test;
use lib my $dir = $?FILE.IO.dirname;

my $exercise = 'FlattenArray';
my $version = v1;
my $module = %*ENV<EXERCISM> ?? 'Example' !! $exercise;
plan 8;

use-ok $module or bail-out;
require ::($module);

if ::($exercise).^ver !~~ $version {
  warn "\nExercise version mismatch. Further tests may fail!"
    ~ "\n$exercise is $(::($exercise).^ver.gist). "
    ~ "Test is $($version.gist).\n";
  bail-out 'Example version must match test version.' if %*ENV<EXERCISM>;
}

require ::($module) <&flatten-array>;

my $c-data;
is-deeply &::('flatten-array')(.<input>), |.<expected description> for @($c-data<cases>);

if %*ENV<EXERCISM> {
  if (my $c-data-file = "$dir/../../x-common/exercises/{$dir.IO.resolve.basename}/canonical-data.json".IO.resolve) ~~ :f {
    is-deeply $c-data, EVAL('use JSON::Fast; from-json($c-data-file.slurp);'), 'canonical-data';
  } else { flunk 'canonical-data' }
} else { skip }

done-testing;

INIT { $c-data := {
  cases    => [
    {
      description => "no nesting".Str,
      expected    => [
        0.Int,
        1.Int,
        2.Int,
      ],
      input       => [
        0.Int,
        1.Int,
        2.Int,
      ],
      property    => "flatten".Str,
    },
    {
      description => "flattens array with just integers present".Str,
      expected    => [
        1.Int,
        2.Int,
        3.Int,
        4.Int,
        5.Int,
        6.Int,
        7.Int,
        8.Int,
      ],
      input       => [
        1.Int,
        [
          2.Int,
          3.Int,
          4.Int,
          5.Int,
          6.Int,
          7.Int,
        ],
        8.Int,
      ],
      property    => "flatten".Str,
    },
    {
      description => "5 level nesting".Str,
      expected    => [
        0.Int,
        2.Int,
        2.Int,
        3.Int,
        8.Int,
        100.Int,
        4.Int,
        50.Int,
        -2.Int,
      ],
      input       => [
        0.Int,
        2.Int,
        [
          [
            2.Int,
            3.Int,
          ],
          8.Int,
          100.Int,
          4.Int,
          [
            [
              [
                50.Int,
              ],
            ],
          ],
        ],
        -2.Int,
      ],
      property    => "flatten".Str,
    },
    {
      description => "6 level nesting".Str,
      expected    => [
        1.Int,
        2.Int,
        3.Int,
        4.Int,
        5.Int,
        6.Int,
        7.Int,
        8.Int,
      ],
      input       => [
        1.Int,
        [
          2.Int,
          [
            [
              3.Int,
            ],
          ],
          [
            4.Int,
            [
              [
                5.Int,
              ],
            ],
          ],
          6.Int,
          7.Int,
        ],
        8.Int,
      ],
      property    => "flatten".Str,
    },
    {
      description => "6 level nest list with null values".Str,
      expected    => [
        0.Int,
        2.Int,
        2.Int,
        3.Int,
        8.Int,
        100.Int,
        -2.Int,
      ],
      input       => [
        0.Int,
        2.Int,
        [
          [
            2.Int,
            3.Int,
          ],
          8.Int,
          [
            [
              100.Int,
            ],
          ],
          (Any),
          [
            [
              (Any),
            ],
          ],
        ],
        -2.Int,
      ],
      property    => "flatten".Str,
    },
    {
      description => "all values in nested list are null".Str,
      expected    => [ ],
      input       => [
        (Any),
        [
          [
            [
              (Any),
            ],
          ],
        ],
        (Any),
        (Any),
        [
          [
            (Any),
            (Any),
          ],
          (Any),
        ],
        (Any),
      ],
      property    => "flatten".Str,
    },
  ],
  exercise => "flatten-array".Str,
  version  => "1.1.0".Str,
} }
