#!/usr/bin/env perl6
use v6;
use Test;
use lib IO::Path.new($?FILE).parent.path;

plan 7;
my $module = %*ENV<EXERCISM> ?? 'Example' !! 'Robot';
use-ok $module;
require ::($module) <Robot>;

ok Robot.can('name'), 'Robot class has name attribute';
ok Robot.can('reset_name'), 'Robot class has reset_name method';

my $robot = Robot.new;
my $name = $robot.name;

like $name, /^^<[A..Z]>**2 <[0..9]>**3$$/, 'Name should match schema';
is $name, $robot.name, 'Name should be persistent';
ok $robot.name ne Robot.new.name, 'Robots should have different names';

$robot.reset_name;

ok $robot.name ne $name, 'reset_name should change the robot name';
