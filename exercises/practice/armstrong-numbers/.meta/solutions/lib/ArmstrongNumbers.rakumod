unit module ArmstrongNumbers;

sub is-armstrong-number ($number) is export {
    $number == sum $number.comb.map: * ** $number.chars
}
