#!/usr/bin/env perl6
use v6;
use Test;
use lib IO::Path.new($?FILE).parent.path;

plan 18;

BEGIN {
  my $module = %*ENV{'EXERCISM'} ?? 'Example' !! 'Raindrops';
  EVAL("use $module")
};

pass 'Load module';


ok Raindrops.can('convert'), 'Class Raindrops has convert method';

is Raindrops.convert(1),      1,                  "test_1";
is Raindrops.convert(3),      "Pling",            "test_3";
is Raindrops.convert(5),      "Plang",            "test_5";
is Raindrops.convert(7),      "Plong",            "test_7";
is Raindrops.convert(6),      "Pling",            "test_6";
is Raindrops.convert(9),      "Pling",            "test_9";
is Raindrops.convert(10),     "Plang",            "test_10";
is Raindrops.convert(14),     "Plong",            "test_14";
is Raindrops.convert(15),     "PlingPlang",       "test_15";
is Raindrops.convert(21),     "PlingPlong",       "test_21";
is Raindrops.convert(25),     "Plang",            "test_25";
is Raindrops.convert(35),     "PlangPlong",       "test_35";
is Raindrops.convert(49),     "Plong",            "test_49";
is Raindrops.convert(52),     52,                 "test_52";
is Raindrops.convert(105),    "PlingPlangPlong",  "test_105";
is Raindrops.convert(12121),  12121,              "test_12121";
