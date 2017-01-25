#!/usr/bin/env perl6

use Test;
use JSON::Tiny;

use lib ( my $dir = IO::Path.new($?FILE).parent ).path;

my $module_name = %*ENV<EXERCISM>.so ?? 'Example' !! 'LinkedList';

require ::($module_name) <LinkedList>;

my @cases = from-json $dir.child('cases.json').slurp;

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
