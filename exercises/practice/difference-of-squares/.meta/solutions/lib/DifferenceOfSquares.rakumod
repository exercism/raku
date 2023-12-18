unit module DifferenceOfSquares;

sub square-of-sum ($number) is export {
    (1..$number).sum²;
}

sub sum-of-squares ($number) is export {
    (1..$number).map(*²).sum;
}

sub difference-of-squares ($number) is export {
    square-of-sum($number) - sum-of-squares($number);
}
