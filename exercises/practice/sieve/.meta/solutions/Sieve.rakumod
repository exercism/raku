unit module Sieve;

sub find-primes ( $limit ) is export {
    sort keys [(^)] gather for 2 .. $limit
    -> $root {
        take { $root * ++$ } ...^ * > $limit
    }
}
