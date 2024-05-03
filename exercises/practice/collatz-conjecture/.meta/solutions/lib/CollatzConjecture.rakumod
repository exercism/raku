unit module CollatzConjecture;

sub collatz-conjecture (UInt $number is copy where * > 0) is export {
    my $i = 0;
    until $number == 1 {
        $i++;

        if $number %% 2 {
            $number = ($number / 2).UInt;
        }
        else {
            ($number *= 3) += 1;
        }
    }

    return $i;
}
