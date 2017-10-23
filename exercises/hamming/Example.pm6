unit module Hamming:ver<1>;

sub hamming-distance ( Str:D $strand1, Str:D $strand2 --> Int:D ) is export {
  die ‘left and right strands must be of equal length’ if $strand1.chars ≠ $strand2.chars;
  ($strand1.comb Zne $strand2.comb).sum
}
