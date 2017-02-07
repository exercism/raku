#!/usr/bin/env perl6

use Test;
use JSON::Tiny;

use lib IO::Path.new($?FILE).parent.path;

my $module = %*ENV<EXERCISM> ?? 'Example' !! 'LinkedList';
require ::($module) <LinkedList>;

my @cases; # defined in INIT

plan 0 + @cases;

for @cases -> $c {
    subtest $c.<name>, sub {
        my $ll = LinkedList.new;
        for  |$c.<set> -> %s {
            for %s {
                my $v = $_.value;
                given $_.key  {
                    when 'push'    { $ll.push( $v );    pass 'push ' ~ $v    }
                    when 'unshift' { $ll.unshift( $v ); pass 'unshift ' ~ $v }
                    when 'pop'     { is $ll.pop,   $v, 'pop'   }
                    when 'shift'   { is $ll.shift, $v, 'shift' }
                }
            }
        }
    };
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
