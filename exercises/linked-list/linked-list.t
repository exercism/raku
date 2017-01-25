#!/usr/bin/env perl6

use Test;
use JSON::Tiny;

use lib ( my $dir = IO::Path.new($?FILE).parent ).path;

my $module_name = %*ENV<EXERCISM>.so ?? 'Example' !! 'LinkedList';
my @potential_module = <p6 pm6 pm>.map:  $module_name ~ '.' ~ *; 

my $module = first { $dir.child($_).e }, |@potential_module
    or die "No file '$module_name.p6' found\n";

require $module <LinkedList>;


my @cases = from-json $dir.child('cases.json').slurp;

for @cases -> $c {
    subtest $c.<name>, sub {
        my $ll = LinkedList.new;
        for  |$c.<set>  -> %s {
            for %s {
                my $v = $_.value;
                given $_.key  {
                    when 'push'    { $ll.push( $v );    pass 'push ' ~ $v    }
                    when 'unshift' { $ll.unshift( $v ); pass 'unshift ' ~ $v }
                    when 'pop'     { is $ll.pop, $v, 'pop' }
                    when 'shift'   { is $ll.shift, $v, 'shift' }
                }
            }
        }
    };
}


done-testing;
