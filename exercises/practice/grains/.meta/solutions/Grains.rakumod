unit module Grains;

sub grains-on-square ( $number where * ∈ 1 .. 64 ) is export {
    2 ** ($number - 1);
}

sub total-grains is export {
    [+] map 1..64: &grains-on-square;
}
