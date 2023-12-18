unit module Pangram;

sub is-pangram (Str:D $_ --> Bool:D) is export {
    .lc.comb ⊇ ‘a’..‘z’
}
