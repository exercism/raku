use v6;
use Test;
use lib './';

plan 8;

BEGIN { EVAL('use Example') }; pass 'Load module';

ok Leap.can('is_leap'), 'Leap class has is_leap() method';

ok my $leap = Leap.new, 'Create new Leap object';

is $leap.is_leap(1996), True,  '1996 is a leap year';
is $leap.is_leap(1997), False, '1997 is not a leap year';
is $leap.is_leap(1998), False, '1998 is not a leap year';
is $leap.is_leap(1900), False, '1900 is not a leap year';
is $leap.is_leap(2400), True,  '2400 is a leap year';
