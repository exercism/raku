#!/usr/bin/env perl6
use v6;
use Test;
use lib IO::Path.new($?FILE).parent.path;

plan 8;
my $module = %*ENV<EXERCISM> ?? 'Example' !! 'Word_Counter';
use-ok $module;
require ::($module) <Word_Counter>;

ok Word_Counter.can('count_words'), 'Class Word_Counter has count_words method';

is-deeply Word_Counter.count_words('word'),                                {word =>  1},                    'one word';
is-deeply Word_Counter.count_words('one of each'),                         {one => 1, of => 1, each => 1},  'one of each';
is-deeply Word_Counter.count_words('one fish two fish red fish blue fish'), 
    {one => 1, fish => 4, two => 1, red => 1, blue => 1}, 
    'multiple occurences';
is-deeply Word_Counter.count_words('car : carpet as java : javascript!!&@$%^&'), 
    {car => 1, carpet => 1, as => 1, java => 1, javascript => 1},
    'ignore punctuation';
is-deeply Word_Counter.count_words('testing, 1, 2 testing'),               {testing => 2, 1 => 1, 2 => 1}, 'include numbers';
is-deeply Word_Counter.count_words('go Go GO'),                            {go => 3},                       'normalize case';


