#!/usr/bin/env perl6
use v6;
use Test;
use lib my $dir = $?FILE.IO.dirname;

my $exercise = 'SpaceAge';
my $version = v1;
my $module = %*ENV<EXERCISM> ?? 'Example' !! $exercise;
plan 10;

use-ok $module or bail-out;
require ::($module);

if ::($exercise).^ver !~~ $version {
  warn "\nExercise version mismatch. Further tests may fail!"
    ~ "\n$exercise is $(::($exercise).^ver.gist). "
    ~ "Test is $($version.gist).\n";
  bail-out 'Example version must match test version.' if %*ENV<EXERCISM>;
}

require ::($module) <Mercury Venus Earth Mars Jupiter Saturn Uranus Neptune>;

my $c-data;
is (age-on ::(.<planet>): .<seconds>), |.<expected description> for @($c-data<cases>);

if %*ENV<EXERCISM> {
  if (my $c-data-file = "$dir/../../x-common/exercises/{$dir.IO.resolve.basename}/canonical-data.json".IO.resolve) ~~ :f {
    is-deeply $c-data, EVAL('use JSON::Fast; from-json($c-data-file.slurp);'), 'canonical-data';
  } else { flunk 'canonical-data' }
} else { skip }

done-testing;

INIT { $c-data := {
  cases    => [
    {
      description => "age on Earth".Str,
      expected    => 31.69.Rat,
      planet      => "Earth".Str,
      property    => "age".Str,
      seconds     => 1000000000.Int,
    },
    {
      description => "age on Mercury".Str,
      expected    => 280.88.Rat,
      planet      => "Mercury".Str,
      property    => "age".Str,
      seconds     => 2134835688.Int,
    },
    {
      description => "age on Venus".Str,
      expected    => 9.78.Rat,
      planet      => "Venus".Str,
      property    => "age".Str,
      seconds     => 189839836.Int,
    },
    {
      description => "age on Mars".Str,
      expected    => 39.25.Rat,
      planet      => "Mars".Str,
      property    => "age".Str,
      seconds     => 2329871239.Int,
    },
    {
      description => "age on Jupiter".Str,
      expected    => 2.41.Rat,
      planet      => "Jupiter".Str,
      property    => "age".Str,
      seconds     => 901876382.Int,
    },
    {
      description => "age on Saturn".Str,
      expected    => 3.23.Rat,
      planet      => "Saturn".Str,
      property    => "age".Str,
      seconds     => 3000000000.Int,
    },
    {
      description => "age on Uranus".Str,
      expected    => 1.21.Rat,
      planet      => "Uranus".Str,
      property    => "age".Str,
      seconds     => 3210123456.Int,
    },
    {
      description => "age on Neptune".Str,
      expected    => 1.58.Rat,
      planet      => "Neptune".Str,
      property    => "age".Str,
      seconds     => 8210123456.Int,
    },
  ],
  exercise => "space-age".Str,
  version  => "1.0.0".Str,
} }
