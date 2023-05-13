unit module PrimeFactors;

sub factors ( $number ) is export {
  use Prime::Factor;
  return prime-factors( $number );
}
