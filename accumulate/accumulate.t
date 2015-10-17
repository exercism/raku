use v6;
use Test;
use lib './';

plan 8;

BEGIN { EVAL('use Example') }; pass 'Load module';
ok Accumulate.can('accumulate'), 'Accumulate class has accumulate() method';

is-deeply Accumulate.accumulate([ ], sub {}),
          [ ],
          'test empty';

is-deeply Accumulate.accumulate([1, 2, 3, 4, 5], sub { @_[0] * @_[0] }),
          [1, 4, 9, 16, 25],
          'raise to 2';

is-deeply Accumulate.accumulate([10, 17, 23], sub { [ (@_[0] / 7).truncate, (@_[0] % 7).truncate ] }),
          [[1, 3], [2, 3], [3, 2] ],
          'divmod';

is-deeply Accumulate.accumulate(['hello', 'exercism'], sub { @_[0].uc }),
          ['HELLO', 'EXERCISM'],
          'capitalize';

is-deeply Accumulate.accumulate(['a', 'b', 'c' ], sub ($inp) { [ Accumulate.accumulate( [1, 2, 3], sub ($inp2) { $inp ~ $inp2 } )]}),
          [['a1', 'a2', 'a3'], ['b1', 'b2', 'b3'], ['c1', 'c2', 'c3']],
          'recursive';

is-deeply Accumulate.accumulate(['the', 'quick', 'brown', 'fox'], sub { @_[0].flip }),
          ['eht', 'kciuq', 'nworb', 'xof'],
          'reverse strings';
