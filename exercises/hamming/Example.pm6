unit module Hamming:ver<3>;

sub hamming-distance (
  +@strands where { .elems == 2 && [==] $_».chars } --> Int:D
) is export {
  sum [Zne] @strands».comb
}
