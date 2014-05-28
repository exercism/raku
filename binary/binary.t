use v6;
use Test;
use lib './';

plan 10;

BEGIN { EVAL('use Example') }; pass ('Load Module');

ok Binary.can('to_decimal'), 'Class Binary has to_decimal method';

is Binary.to_decimal('1'), 1, '"1" returns 1';
is Binary.to_decimal('10'), 2, '"10" returns 2';
is Binary.to_decimal('11'), 3, '"11" returns 3';
is Binary.to_decimal('100'), 4, '"100" returns 4';
is Binary.to_decimal('1001'), 9, '"1001" returns 9';
is Binary.to_decimal('11010'), 26, '"11010" returns 26';
is Binary.to_decimal('10001101000'), 1128, '"10001101000" returns 1128';
is Binary.to_decimal('carrot23'), 0, '"carrot23" returns 0';
