unit class AffineCipher;

has $.a;
has $.b;
has @!letters = ('a'..'z');
has $!m       = @!letters.elems;

method encode ($phrase) {
    return $phrase;
}

method decode ($phrase) {
    return $phrase;
}

submethod TWEAK {
    for 2..$!a {
        die if ($!a & $!m) %% $_;
    }
}
