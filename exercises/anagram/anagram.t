#!/usr/bin/env perl6
use v6;
use Test;
use lib IO::Path.new($?FILE).parent.path;

plan 11;

BEGIN {
  my $module = %*ENV{'EXERCISM'} ?? 'Example' !! 'Anagram';
  EVAL("use $module")
};

pass 'Load module';

ok Anagram.can('match'), 'Class Anagram has match method';

is-deeply Anagram.match('diaper', ['hello', 'world', 'zombies', 'pants']), [], 'no matches';
is-deeply Anagram.match('ant', ['tan', 'stand', 'at']), ['tan'], 'detect simple anagram';
is-deeply Anagram.match('master', ['stream', 'pigeon', 'maters']), ['stream', 'maters'], 'multiple anagrams';
is-deeply Anagram.match('galea', ['eagle']), [], 'does not confuse different duplicates';
is-deeply Anagram.match('good', ['dog', 'goody']), [], 'eleminates anagram subsets';
is-deeply Anagram.match('listen', ['enlists', 'google', 'inlets', 'banana']), ['inlets'], 'detect anagram';
is-deeply Anagram.match('allergy', ['gallery', 'ballerina', 'regally', 'clergy', 'largely', 'leading']), ['gallery', 'regally', 'largely'], 'multiple anagrams';
is-deeply Anagram.match('Orchestra', ['cashregister', 'Carthorse', 'radishes']), ['Carthorse'], 'anagrams are case-insensitive';
is-deeply Anagram.match('banana', ['banana', 'Banana']), [], 'same word is not an anagram, whatever the case';
