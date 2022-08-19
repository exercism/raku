unit class AffineCipher;

constant @alphabet = 'a'..'z';
constant $m        = @alphabet.elems;

has $.a;
has $.b;

submethod TWEAK {
    die if $!a gcd $m != 1;
}

submethod mmi {
    my ($t, $newt, $r, $newr) = 0, 1, $m, $!a;

    while $newr != 0 {
        given $r div $newr -> $quotient {
            ($t, $newt) = $newt, $t − $quotient × $newt;
            ($r, $newr) = $newr, $r − $quotient × $newr;
        }
    }

    return $t
}

method encode ($phrase) {
    gather for $phrase.lc.comb: / <:Number> | <:Letter> / {
        when / <:Number> / { .take }
        when / <:Letter> / {
            take @alphabet[
                ( $.a × %(@alphabet.antipairs){ $_ } + $.b ) % $m
            ]
        }
    }.join.comb: 5
}

method decode ($phrase) {
    gather for $phrase.lc.comb: / <:Number> | <:Letter> / {
        when / <:Number> / { .take }
        when / <:Letter> / {
            take @alphabet[
                $.mmi × ( %(@alphabet.antipairs){ $_ } - $.b ) % $m
            ]
        }
    }.join
}
