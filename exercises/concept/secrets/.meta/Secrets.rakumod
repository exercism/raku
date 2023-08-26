unit module SecretDevice;

sub secret-add ($secret --> Block) is export {
    return -> $x { $x + $secret };
}

sub secret-subtract ($secret --> Block) is export {
    return -> $x { $x - $secret };
}

sub secret-multiply ($secret --> Block) is export {
    return -> $x { $x × $secret };
}

sub secret-divide ($secret --> Block) is export {
    return -> $x { $x ÷ $secret };
}

sub secret-combine ($func1, $func2 --> Block) is export {
    return -> $x { $x ==> $func1() ==> $func2() };
}
