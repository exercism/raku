unit module PrimeFactors;

multi factors ( 1, | ) is export          { Empty };
multi factors ( $n where $n.is-prime, | ) { $n    };
multi factors ( $n, @primes = ( 2 .. * ).grep: *.is-prime ) {
  given $n %% @primes.head {
    when *.so { @primes.head, factors( $n div @primes.head, @primes      ).Slip }
    default   {               factors( $n,                  @primes.skip )      }
  }
}
