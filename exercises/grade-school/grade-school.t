#!/usr/bin/env perl6
use v6;
use Test;
use lib $?FILE.IO.dirname;

my Str:D $exercise := 'GradeSchool';
my Version:D $version = v1;
my Str $module //= $exercise;
plan 10;

use-ok $module or bail-out;
require ::($module);

if ::($exercise).^ver !~~ $version {
  warn "\nExercise version mismatch. Further tests may fail!"
    ~ "\n$exercise is $(::($exercise).^ver.gist). "
    ~ "Test is $($version.gist).\n";
  bail-out 'Example version must match test version.' if %*ENV<EXERCISM>;
}

require ::($module) <Roster>;

subtest "Roster class methods", {
  plan 3;
  ok ::('Roster').can($_), $_ for <add-student list-grade list-all>;
}
my $roster = ::('Roster').new;
ok $roster.?add-student(:name('Jim'), :2grade), 'Add Jim to grade 2';
is $roster.?list-grade(2), <Jim>, 'List grade 2';
ok $roster.?add-student(:name('Zoe'), :2grade), 'Add Zoe to grade 2';
ok $roster.?add-student(:name('Barb'), :1grade), 'Add Barb to grade 1';
is $roster.?list-grade(2), <Jim Zoe>, 'List grade 2';
is $roster.?list-grade(1), <Barb>, 'List grade 1';
subtest 'Additional students', {
  plan 6;
  ok $roster.?add-student(:name($_), :1grade), "Add $_ to grade 1" for <Charlie Anna>;
  ok $roster.?add-student(:name('Alex'), :2grade), 'Add Alex to grade 2';
  ok $roster.?add-student(:name($_), :3grade), "Add $_ to grade 3" for <Tom Dick Harry>;
}
is $roster.?list-all, ('Grade 1', <Anna Barb Charlie>, 'Grade 2', <Alex Jim Zoe>, 'Grade 3', <Dick Harry Tom>), 'List all';

done-testing;

INIT {
  if %*ENV<EXERCISM> {
    $module = 'Example';
  }
}
