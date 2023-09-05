unit module PerfectNumbers;

enum AliquotSumType is export (
  :Deficient(Less),
  :Perfect(Same),
  :Abundant(More),
);

sub prime-factors ( $n is copy ) {
  gather for grep *.is-prime, flat 2 .. $n.sqrt, $n
  -> $prime {
    take $n     and last           if    $n.is-prime;
    take $prime and $n div= $prime while $n %% $prime
  }
}

sub aliquot-sum-type ( Int $n where 1..*, @pf = prime-factors( $n ) --> AliquotSumType ) is export {
  return Deficient if @pf == ();
  AliquotSumType( @pf.combinations( 1 .. @pf.end ).unique( with => &[eqv] ).map( { [*] $_ } ).sum.succ cmp $n )
}
