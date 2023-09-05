unit module PerfectNumbers;

sub prime-factors ( $n is copy ) {
  gather for grep *.is-prime, flat 2 .. $n.sqrt, $n
  -> $prime {
    take $n     and last           if    $n.is-prime;
    take $prime and $n div= $prime while $n %% $prime
  }
}
sub aliquot-sum-type ( Int $n where 1..*, @pf = prime-factors( $n ) ) is export {
  return 'deficient' if @pf == ();
  given @pf.combinations( 1 .. @pf.elems.pred ).unique( with => &[eqv] ).map( { [*] $_ } ).sum.succ {
    when    $_ > $n { 'abundant'  }
    when    $n      { 'perfect'   }
    default         { 'deficient' }
  }
}
