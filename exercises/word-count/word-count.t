#!/usr/bin/env perl6
use v6;
use Test;
use lib my $dir = $?FILE.IO.dirname;

my $exercise = 'WordCount';
my $version = v1;
my $module = %*ENV<EXERCISM> ?? 'Example' !! $exercise;
plan 12;

use-ok $module or bail-out;
require ::($module);

if ::($exercise).^ver !~~ $version {
  warn "\nExercise version mismatch. Further tests may fail!"
    ~ "\n$exercise is $(::($exercise).^ver.gist). "
    ~ "Test is $($version.gist).\n";
  bail-out 'Example version must match test version.' if %*ENV<EXERCISM>;
}

require ::($module) <&count-words>;

my $c-data;
is-deeply (% = .<input>.&count-words), |.<expected description> for @($c-data<cases>);

if %*ENV<EXERCISM> {
  if (my $c-data-file = "$dir/../../x-common/exercises/{$dir.IO.resolve.basename}/canonical-data.json".IO.resolve) ~~ :f {
    is-deeply $c-data, EVAL('use JSON::Fast; from-json($c-data-file.slurp);'), 'canonical-data';
  } else { flunk 'canonical-data' }
} else { skip }

done-testing;

INIT { $c-data := {
  cases    => [
    {
      description => "count one word".Str,
      expected    => {
        word => 1.Int,
      },
      input       => "word".Str,
      property    => "countwords".Str,
    },
    {
      description => "count one of each word".Str,
      expected    => {
        each => 1.Int,
        of   => 1.Int,
        one  => 1.Int,
      },
      input       => "one of each".Str,
      property    => "countwords".Str,
    },
    {
      description => "multiple occurrences of a word".Str,
      expected    => {
        blue => 1.Int,
        fish => 4.Int,
        one  => 1.Int,
        red  => 1.Int,
        two  => 1.Int,
      },
      input       => "one fish two fish red fish blue fish".Str,
      property    => "countwords".Str,
    },
    {
      description => "handles cramped lists".Str,
      expected    => {
        one   => 1.Int,
        three => 1.Int,
        two   => 1.Int,
      },
      input       => "one,two,three".Str,
      property    => "countwords".Str,
    },
    {
      description => "handles expanded lists".Str,
      expected    => {
        one   => 1.Int,
        three => 1.Int,
        two   => 1.Int,
      },
      input       => "one,\ntwo,\nthree".Str,
      property    => "countwords".Str,
    },
    {
      description => "ignore punctuation".Str,
      expected    => {
        as         => 1.Int,
        car        => 1.Int,
        carpet     => 1.Int,
        java       => 1.Int,
        javascript => 1.Int,
      },
      input       => "car: carpet as java: javascript!!\&\@\$\%^\&".Str,
      property    => "countwords".Str,
    },
    {
      description => "include numbers".Str,
      expected    => {
        1       => 1.Int,
        2       => 1.Int,
        testing => 2.Int,
      },
      input       => "testing, 1, 2 testing".Str,
      property    => "countwords".Str,
    },
    {
      description => "normalize case".Str,
      expected    => {
        go   => 3.Int,
        stop => 2.Int,
      },
      input       => "go Go GO Stop stop".Str,
      property    => "countwords".Str,
    },
    {
      description => "with apostrophes".Str,
      expected    => {
        cry   => 1.Int,
        don't => 2.Int,
        first => 1.Int,
        laugh => 1.Int,
        then  => 1.Int,
      },
      input       => "First: don't laugh. Then: don't cry.".Str,
      property    => "countwords".Str,
    },
    {
      description => "with quotations".Str,
      expected    => {
        and     => 1.Int,
        between => 1.Int,
        can't   => 1.Int,
        joe     => 1.Int,
        large   => 2.Int,
        tell    => 1.Int,
      },
      input       => "Joe can't tell between 'large' and large.".Str,
      property    => "countwords".Str,
    },
  ],
  comments => [
    "For each word in the input, count the number of times it appears in the".Str,
    "entire sentence.".Str,
  ],
  exercise => "word-count".Str,
  version  => "1.0.0".Str,
} }
