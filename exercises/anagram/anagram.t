#!/usr/bin/env perl6
use v6;
use Test;
use lib my $dir = $?FILE.IO.dirname;

my $exercise = 'Anagram';
my $version = v1;
my $module = %*ENV<EXERCISM> ?? 'Example' !! $exercise;
plan 18;

use-ok $module or bail-out;
require ::($module);

if ::($exercise).^ver !~~ $version {
  warn "\nExercise version mismatch. Further tests may fail!"
    ~ "\n$exercise is $(::($exercise).^ver.gist). "
    ~ "Test is $($version.gist).\n";
  bail-out 'Example version must match test version.' if %*ENV<EXERCISM>;
}

require ::($module) <&match-anagrams>;

my $c-data;
is match-anagrams(|.<subject candidates>), |.<expected description> for @($c-data<cases>);

if %*ENV<EXERCISM> {
  if (my $c-data-file = "$dir/../../x-common/exercises/{$dir.IO.resolve.basename}/canonical-data.json".IO.resolve) ~~ :f {
    is-deeply $c-data, EVAL('use JSON::Fast; from-json($c-data-file.slurp);'), 'canonical-data';
  } else { flunk 'canonical-data' }
} else { skip }

done-testing;

INIT { $c-data := {
  cases    => [
    {
      candidates  => [
        "hello".Str,
        "world".Str,
        "zombies".Str,
        "pants".Str,
      ],
      description => "no matches".Str,
      expected    => [ ],
      property    => "anagrams".Str,
      subject     => "diaper".Str,
    },
    {
      candidates  => [
        "tan".Str,
        "stand".Str,
        "at".Str,
      ],
      description => "detects simple anagram".Str,
      expected    => [
        "tan".Str,
      ],
      property    => "anagrams".Str,
      subject     => "ant".Str,
    },
    {
      candidates  => [
        "eagle".Str,
      ],
      description => "does not detect false positives".Str,
      expected    => [ ],
      property    => "anagrams".Str,
      subject     => "galea".Str,
    },
    {
      candidates  => [
        "stream".Str,
        "pigeon".Str,
        "maters".Str,
      ],
      description => "detects two anagrams".Str,
      expected    => [
        "stream".Str,
        "maters".Str,
      ],
      property    => "anagrams".Str,
      subject     => "master".Str,
    },
    {
      candidates  => [
        "dog".Str,
        "goody".Str,
      ],
      description => "does not detect anagram subsets".Str,
      expected    => [ ],
      property    => "anagrams".Str,
      subject     => "good".Str,
    },
    {
      candidates  => [
        "enlists".Str,
        "google".Str,
        "inlets".Str,
        "banana".Str,
      ],
      description => "detects anagram".Str,
      expected    => [
        "inlets".Str,
      ],
      property    => "anagrams".Str,
      subject     => "listen".Str,
    },
    {
      candidates  => [
        "gallery".Str,
        "ballerina".Str,
        "regally".Str,
        "clergy".Str,
        "largely".Str,
        "leading".Str,
      ],
      description => "detects three anagrams".Str,
      expected    => [
        "gallery".Str,
        "regally".Str,
        "largely".Str,
      ],
      property    => "anagrams".Str,
      subject     => "allergy".Str,
    },
    {
      candidates  => [
        "corn".Str,
        "dark".Str,
        "Corn".Str,
        "rank".Str,
        "CORN".Str,
        "cron".Str,
        "park".Str,
      ],
      description => "does not detect identical words".Str,
      expected    => [
        "cron".Str,
      ],
      property    => "anagrams".Str,
      subject     => "corn".Str,
    },
    {
      candidates  => [
        "last".Str,
      ],
      description => "does not detect non-anagrams with identical checksum".Str,
      expected    => [ ],
      property    => "anagrams".Str,
      subject     => "mass".Str,
    },
    {
      candidates  => [
        "cashregister".Str,
        "Carthorse".Str,
        "radishes".Str,
      ],
      description => "detects anagrams case-insensitively".Str,
      expected    => [
        "Carthorse".Str,
      ],
      property    => "anagrams".Str,
      subject     => "Orchestra".Str,
    },
    {
      candidates  => [
        "cashregister".Str,
        "carthorse".Str,
        "radishes".Str,
      ],
      description => "detects anagrams using case-insensitive subject".Str,
      expected    => [
        "carthorse".Str,
      ],
      property    => "anagrams".Str,
      subject     => "Orchestra".Str,
    },
    {
      candidates  => [
        "cashregister".Str,
        "Carthorse".Str,
        "radishes".Str,
      ],
      description => "detects anagrams using case-insensitive possible matches".Str,
      expected    => [
        "Carthorse".Str,
      ],
      property    => "anagrams".Str,
      subject     => "orchestra".Str,
    },
    {
      candidates  => [
        "Banana".Str,
      ],
      description => "does not detect a word as its own anagram".Str,
      expected    => [ ],
      property    => "anagrams".Str,
      subject     => "banana".Str,
    },
    {
      candidates  => [
        "go Go GO".Str,
      ],
      description => "does not detect a anagram if the original word is repeated".Str,
      expected    => [ ],
      property    => "anagrams".Str,
      subject     => "go".Str,
    },
    {
      candidates  => [
        "patter".Str,
      ],
      description => "anagrams must use all letters exactly once".Str,
      expected    => [ ],
      property    => "anagrams".Str,
      subject     => "tapper".Str,
    },
    {
      candidates  => [
        "Banana".Str,
      ],
      description => "capital word is not own anagram".Str,
      expected    => [ ],
      property    => "anagrams".Str,
      subject     => "BANANA".Str,
    },
  ],
  comments => [
    "The string argument cases possible matches are passed in as".Str,
    "individual arguments rather than arrays. Languages can include".Str,
    "these string argument cases if passing individual arguments is".Str,
    "idiomatic in that language.".Str,
  ],
  exercise => "anagram".Str,
  version  => "1.0.1".Str,
} }
