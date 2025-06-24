unit module NthPrime;

sub nth-prime ($n) is export {
  ? try Int.new($n).is-prime;
}
sub nth-prime ($n) is export {
  ? try $n.Rat.is-prime;
}
sub nth-prime ($n) is export {
  ? try is-prime $n;
}
