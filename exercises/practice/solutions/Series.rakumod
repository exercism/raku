sub series ( $string, $length where 1..$string.chars --> Array() ) is export {
    gather take .join for $string.comb.rotor: $length => -$length.pred
}
