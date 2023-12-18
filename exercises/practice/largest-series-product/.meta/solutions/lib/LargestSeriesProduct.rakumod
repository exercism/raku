unit module LargestSeriesProduct;

proto largest-product (|) is export {*}
multi largest-product ( $n, 0 ) { 1 }
multi largest-product ( $n, Int $span where 1 .. $n.chars ) {

    $n
    .comb
    .rotor( $span => - $span.pred )
    .map(          *.reduce: &[*] )
    .max

}
