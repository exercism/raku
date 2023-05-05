sub series ( Str $string, Int $length where 1..$string.chars ) is export {
    gather take .join for $string.comb.rotor: $length => -$length.pred
}
