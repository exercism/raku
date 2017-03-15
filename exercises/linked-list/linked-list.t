#!/usr/bin/env perl6
use v6;
use Test;
use lib $?FILE.IO.dirname;
use JSON::Tiny;

my $exercise = 'LinkedList';
my $version = v1;
my $module = %*ENV<EXERCISM> ?? 'Example' !! $exercise;
plan 7;

use-ok $module or bail-out;
require ::($module);
if ::($exercise).^ver !~~ $version {
  warn "\nExercise version mismatch. Further tests may fail!"
    ~ "\n$exercise is $(::($exercise).^ver.gist). "
    ~ "Test is $($version.gist).\n";
  bail-out 'Example version must match test version.' if %*ENV<EXERCISM>;
}

subtest "Class method(s)", {
   plan 4;
   ok ::($exercise).can($_), $_ for <push-list pop-list shift-list unshift-list>;
}

for my @cases -> $case {
  subtest $case.<name>, sub {
    my $linkedlist = ::($exercise).new;
    for  |$case.<set> -> %set {
      for %set {
        my $value = $_.value;
        given $_.key  {
          when 'push'    { $linkedlist.?push-list( $value ) }
          when 'unshift' { $linkedlist.?unshift-list( $value ) }
          when 'pop'     { is $linkedlist.?pop-list, $value, 'pop' }
          when 'shift'   { is $linkedlist.?shift-list, $value, 'shift' }
        }
      }
    }
  }
}

done-testing;

INIT {
  @cases := from-json ｢
    [
      {
        "set" : [
          { "push" : 10 },
          { "push" : 20 },
          { "pop"  : 20 },
          { "pop"  : 10 }
        ],
        "name" : "push_pop"
      },
      {
        "set" : [
          { "push" : 10  },
          { "push" : 20  },
          { "shift" : 10 },
          { "shift" : 20 }
        ],
        "name" : "push_shift"
      },
      {
        "set" : [
          { "unshift" : 10 },
          { "unshift" : 20 },
          { "shift"   : 20 },
          { "shift"   : 10 }
        ],
        "name" : "unshift_shift"
      },
      {
        "set" : [
          { "unshift" : 10 },
          { "unshift" : 20 },
          { "pop"     : 10 },
          { "pop"     : 20 }
        ],
        "name" : "unshift_pop"
      },
      {
        "set" : [
          { "push"    : 10 },
          { "push"    : 20 },
          { "pop"     : 20 },
          { "push"    : 30 },
          { "shift"   : 10 },
          { "unshift" : 40 },
          { "push"    : 50 },
          { "shift"   : 40 },
          { "pop"     : 50 },
          { "shift"   : 30 }
        ],
        "name" : "example"
      }
    ]
  ｣
}
