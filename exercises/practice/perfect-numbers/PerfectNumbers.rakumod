unit module PerfectNumbers;

enum AliquotSumType is export (
    :Deficient(-1),
    :Perfect(0),
    :Abundant(1),
);

sub aliquot-sum-type ( $n --> AliquotSumType ) is export {
}
