#!/usr/bin/env perl6
use v6;
use Test;
use lib IO::Path.new($?FILE).parent.path;

plan 11;

BEGIN {
  my $module = %*ENV{'EXERCISM'} ?? 'Example' !! 'Grains';
  EVAL("use $module")
};

pass 'Load module';

ok Grains.can('square'), 'Grains class has square method';
ok Grains.can('total'), 'Grains class has total method';

is Grains.square(1),  1, 'test square 1';
is Grains.square(2),  2, 'test square 2';
is Grains.square(3),  4, 'test square 3';
is Grains.square(4),  8,  'test square 4';
is Grains.square(16), 32768, 'test square 16';
is Grains.square(32), 2147483648, 'test square 32';
is Grains.square(64), 9223372036854775808, 'test square 64';
is Grains.total,      18446744073709551615, 'test total';
