#!/usr/bin/env perl6
use v6;
use Test;
use lib $?FILE.IO.dirname;
use Accumulate;
plan 6;

is-deeply accumulate([ ], sub {}),
          [ ],
          'test empty';
is-deeply accumulate([1, 2, 3, 4, 5], sub { @_[0] * @_[0] }),
          [1, 4, 9, 16, 25],
          'raise to 2';
is-deeply accumulate([10, 17, 23], sub { [ (@_[0] / 7).truncate, (@_[0] % 7).truncate ] }),
          [[1, 3], [2, 3], [3, 2] ],
          'divmod';
is-deeply accumulate(['hello', 'exercism'], sub { @_[0].uc }),
          ['HELLO', 'EXERCISM'],
          'capitalize';
is-deeply accumulate(['a', 'b', 'c' ], sub ($inp) { [ accumulate( [1, 2, 3], sub ($inp2) { $inp ~ $inp2 } )]}),
          [['a1', 'a2', 'a3'], ['b1', 'b2', 'b3'], ['c1', 'c2', 'c3']],
          'recursive';
is-deeply accumulate(['the', 'quick', 'brown', 'fox'], sub { @_[0].flip }),
          ['eht', 'kciuq', 'nworb', 'xof'],
          'reverse strings';
