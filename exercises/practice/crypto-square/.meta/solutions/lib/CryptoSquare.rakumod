unit module CryptoSquare;

sub crypto-square ($text is copy) is export {
    $text.=lc.=subst(/<:!Ll + :!Nd>/, :g);
    return '' unless $text;
    my $c = 1;
    $c++ while $c² < $text.chars;
    my $r = $c;
    $r -= 1 if $c * ($r - 1) ≥ $text.chars;
    $text ~= ' ' x ( ($c * $r) - $text.chars);
    my @square = $text.comb($c).map(*.comb);
    my @result;
    for ^$c {
        @result.push(@square[*;$_].join);
    }
    return @result.join(' ');
}
