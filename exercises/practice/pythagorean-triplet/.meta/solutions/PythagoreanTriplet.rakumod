unit module PythagoreanTriplet;

sub triplets-sum ($sum) is export {
    gather for 1 .. $sum
    -> $a {
        given 2×$a² + $sum² - 2×$sum×$a, 2×( $sum - $a )
        -> ( $numerator, $denominator ) {
            if $numerator %% $denominator {
                my $c = $numerator / $denominator;
                my $b = $sum - $a - $c;
                take [ $a, $b, $c ] if $b > $a;
            }
        }
    }
}
