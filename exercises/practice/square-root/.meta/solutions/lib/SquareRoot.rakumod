unit module SquareRoot;

proto square-root (|) is export {*}
multi square-root(  0 ) { 0 }
multi square-root(  1 ) { 1 }
multi square-root( $n ) {
  my $x0 = 2 ** ( floor( log2 $n / 2 ) + 1 );
  my $x1 = ( $x0 + $n div $x0 ) div 2;
  while $x1 < $x0 {
    $x0 = $x1;
    $x1 = ( $x0 + $n div $x0 ) div 2;
  }
  return $x0;
}
