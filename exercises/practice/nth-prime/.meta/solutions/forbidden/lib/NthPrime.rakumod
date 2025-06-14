unit module NthPrime;

sub nth-prime ($n) is export {
    ? try Int.new($n).is-prime;
}
