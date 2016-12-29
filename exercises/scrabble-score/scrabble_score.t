#!/usr/bin/env perl6
use v6;
use Test;
use lib IO::Path.new($?FILE).parent.path;

plan 10;
my $module = %*ENV<EXERCISM> ?? 'Example' !! 'Scrabble';
use-ok $module;
require ::($module) <Scrabble>;

ok Scrabble.can('score'), 'Scrabble class has score() method';

my $scrabble = Scrabble.new();

is $scrabble.score(""),                 0,  "empty word scores 0";
is $scrabble.score(" \t\n"),            0,  "whitespace scores 0";
is $scrabble.score("a"),                1,  "a scores 1";
is $scrabble.score("f"),                4,  "f scores 4";
is $scrabble.score("street"),           6,  "street scores 6";
is $scrabble.score("alacrity"),         13, "alacrity scores 13";
is $scrabble.score("OXYPHENBUTAZONE"),  41, "OXYPHENBUTAZONE scores 41";
is $scrabble.score("quirky"),           22, "quirky scores 22";
