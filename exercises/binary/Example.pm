class Binary {
    method to_decimal ($binary) {
        return 0 if $binary ~~ /<-[^01]>/;

        my $decimal = 0;
        my $index = $binary.chars;

        for $binary.split('',:skip-empty) -> $bit {
           $decimal += $bit * 2 ** --$index;
        }
        return $decimal;
    }
}
