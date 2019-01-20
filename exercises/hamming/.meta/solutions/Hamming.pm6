unit module Hamming;

sub hamming-distance (
  +@strands where { .elems == 2 && [==] $_».chars } --> Int:D
) is export {
  [+] [Zne] @strands».comb;
}
