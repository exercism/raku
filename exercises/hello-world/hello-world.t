#!/usr/bin/env perl6
use v6;
use Test;
use lib IO::Path.new($?FILE).parent.path;

my $exercise = 'HelloWorld';
my $version = v1;
my $module = %*ENV<EXERCISM> ?? 'Example' !! $exercise;
plan 6;

use-ok $module or bail-out;
require ::($module);
if ::($exercise).^ver !~~ $version {
  warn "\nExercise version mismatch. Further tests may fail!"
    ~ "\n$exercise is $(::($exercise).^ver.gist). "
    ~ "Test is $($version.gist).\n";
  bail-out 'Example version must match test version.' if %*ENV<EXERCISM>;
}

my @subs;
BEGIN { @subs = <&hello> };
subtest 'Subroutine(s)', {
  plan 1;
  eval-lives-ok "use $module; ::('$_').defined or die '$_ is not defined.'", $_ for @subs;
} or bail-out 'All subroutines must be defined and exported.';
require ::($module) @subs.eager;

is hello, 'Hello, World!', 'No argument';
is ''.&hello, 'Hello, World!', 'Empty string';
todo 'optional test', 2 unless %*ENV<EXERCISM>;
is 'Camelia'.&hello, 'Hello, Camelia!', 'Camelia';
is '楽土'.&hello, 'Hello, 楽土!', 'Rakudo';
