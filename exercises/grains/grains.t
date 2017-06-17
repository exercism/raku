#!/usr/bin/env perl6
use v6;
use Test;
use lib my $dir = $?FILE.IO.dirname;

my $exercise = 'Grains';
my $version = v1;
my $module = %*ENV<EXERCISM> ?? 'Example' !! $exercise;
plan 13;

use-ok $module or bail-out;
require ::($module);

if ::($exercise).^ver !~~ $version {
  warn "\nExercise version mismatch. Further tests may fail!"
    ~ "\n$exercise is $(::($exercise).^ver.gist). "
    ~ "Test is $($version.gist).\n";
  bail-out 'Example version must match test version.' if %*ENV<EXERCISM>;
}

require ::($module) <&grains-on-square &total-grains>;

my $c-data;
for @($c-data<cases>[0]<cases>) {
  if .<expected> == -1 {
    throws-like { grains-on-square(.<input>) }, Exception, .<description>;
  } else {
    is grains-on-square(.<input>), |.<expected description>;
  }
}
is total-grains, |$c-data<cases>[1]<expected description>;

if %*ENV<EXERCISM> {
  if (my $c-data-file = "$dir/../../x-common/exercises/{$dir.IO.resolve.basename}/canonical-data.json".IO.resolve) ~~ :f {
    is-deeply $c-data, EVAL('use JSON::Fast; from-json($c-data-file.slurp);'), 'canonical-data';
  } else { flunk 'canonical-data' }
} else { skip }

done-testing;

INIT { $c-data := {
  cases    => [
    {
      cases       => [
        {
          description => "1".Str,
          expected    => 1.Int,
          input       => 1.Int,
          property    => "square".Str,
        },
        {
          description => "2".Str,
          expected    => 2.Int,
          input       => 2.Int,
          property    => "square".Str,
        },
        {
          description => "3".Str,
          expected    => 4.Int,
          input       => 3.Int,
          property    => "square".Str,
        },
        {
          description => "4".Str,
          expected    => 8.Int,
          input       => 4.Int,
          property    => "square".Str,
        },
        {
          description => "16".Str,
          expected    => 32768.Int,
          input       => 16.Int,
          property    => "square".Str,
        },
        {
          description => "32".Str,
          expected    => 2147483648.Int,
          input       => 32.Int,
          property    => "square".Str,
        },
        {
          description => "64".Str,
          expected    => 9223372036854775808.Int,
          input       => 64.Int,
          property    => "square".Str,
        },
        {
          description => "square 0 raises an exception".Str,
          expected    => -1.Int,
          input       => 0.Int,
          property    => "square".Str,
        },
        {
          description => "negative square raises an exception".Str,
          expected    => -1.Int,
          input       => -1.Int,
          property    => "square".Str,
        },
        {
          description => "square greater than 64 raises an exception".Str,
          expected    => -1.Int,
          input       => 65.Int,
          property    => "square".Str,
        },
      ],
      description => "returns the number of grains on the square".Str,
    },
    {
      description => "returns the total number of grains on the board".Str,
      expected    => 18446744073709551615.Int,
      property    => "total".Str,
    },
  ],
  comments => [
    "The final tests of square test error conditions".Str,
    "The expection for these tests is -1, indicating an error".Str,
    "In these cases you should expect an error as is idiomatic for your language".Str,
  ],
  exercise => "grains".Str,
  version  => "1.0.0".Str,
} }
