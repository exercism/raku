#!/usr/bin/env perl6
use v6;
use Test;
use lib $?FILE.IO.dirname;
use Robot;
plan 7;

my Version:D $version = v2;

if Robot.^ver !~~ $version {
  warn "\nExercise version mismatch. Further tests may fail!"
    ~ "\nRobot is {Robot.^ver.gist}. "
    ~ "Test is {$version.gist}.\n";
}

subtest 'Class methods', {
  ok Robot.can($_), $_ for <name reset-name>;
}

srand 1;
my $robot = Robot.?new;
my Str $name = $robot.?name;
like $name, /^^<[A..Z]>**2 <[0..9]>**3$$/, 'Name matches schema';

srand 2;
is $robot.?name, $name, 'Name is persistent';
srand 1;
isnt Robot.new.?name, $name, 'New Robot cannot claim previous Robot name';

srand 1;
$robot.?reset-name;
$robot.?reset_name; # Allows next test to still pass for older solutions

isnt $robot.?name, $name, "'reset-name' cannot use previous Robot name";

diag "\nCreating 100 robots...";
push my @names, Robot.new.name for 1..100;
is @names, @names.unique, 'All names are unique';
subtest 'Randomness', {
  plan 2;
  isnt @names, @names.sort, 'Names not ordered';
  isnt @names, @names.sort.reverse, 'Names not reverse ordered';
}
