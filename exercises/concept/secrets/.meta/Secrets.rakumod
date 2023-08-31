unit module Secrets;

sub secret-add ($secret --> Code) is export {
    # Explicit signature
    return -> $x { $x + $secret };
}

sub secret-subtract ($secret --> Code) is export {
    # Twigil signature
    return { $^x - $secret };
}

sub secret-multiply ($secret --> Code) is export {
    # Topic variable
    return { $_ * $secret };
}

sub secret-divide ($secret --> Code) is export {
    # WhateverCode
    return * / $secret;
}

sub secret-combine ($func1, $func2 --> Code) is export {
    return -> $x { $func2( $func1( $x ) ) };
}
