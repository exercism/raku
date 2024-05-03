unit module PerfectNumbers;

enum AliquotSumType is export (
    :Deficient(Less),
    :Perfect(Same),
    :Abundant(More),
);

sub aliquot-sum-type ( $n --> AliquotSumType ) is export {
}
