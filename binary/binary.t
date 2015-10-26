use v6;
use Test;
use lib './';

BEGIN {
    plan 10;

    my @files = <Example Binary>;
    my $file = @files.grep({ ( $_ ~ '.pm' ).IO.f })[0] 
        or exit flunk "neither " ~ ( @files.map({ $_ ~ '.pm' }).join( ' or ' ) ) ~ ' found';
    EVAL( 'use ' ~ $file );
    pass 'Load module';
}

ok Binary.can('to_decimal'), 'Class Binary has to_decimal method';

my %results = (
    1           => 1,
    10          => 2,
    11          => 3,
    100         => 4,
    1001        => 9,
    11010       => 26,
    10001101000 => 1128,
    'carrot23'  => 0,
);

for %results.sort {
    is Binary.to_decimal($_.key), $_.value, '"' ~ $_.key ~ '" returns ' ~ $_.value;
}
