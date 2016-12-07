unit module AllYourBase;

sub convert-base(@digits,$in_base,$out_base) is export { 
    my $number = reduce { $^a * $in_base + $^b }, 0, |@digits;

    die "base must be greater than 1" if ($in_base,$out_base).any <= 1;

    die "negative digit not allowed" if @digits.any < 0;

    die "digit equal or greater than the base" if @digits.any >= $in_base;    

    my @new_base = gather {
        while $number > 0 {
            take $number mod $out_base;
            $number = $number div $out_base;
        }
    };

    @new_base = [0] unless @new_base;

    return @new_base.reverse;
}
