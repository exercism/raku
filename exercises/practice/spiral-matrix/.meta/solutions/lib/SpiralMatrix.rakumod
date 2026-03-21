unit module SpiralMatrix;

sub rotate-matrix (@m) {
    reverse map *.Array, [Z] @m
}
multi normalize ([]) { return [] }
multi normalize (@m) {
    @m = rotate-matrix @m while @m[0][0] != 1;
    return @m;
}
sub fill-row (@m, $count is rw) {
    my $row = .key with first { 0 (elem) .value }, @m.pairs orelse return @m;
    @m[$row][$_] = ++$count if @m[$row][$_] == 0 for ^@m.head.elems;
    return @m;
}
sub spiral-matrix ($n) is export {
    my $count = 0;
    my @m = [[0 xx $n] xx $n];
    fill-row(@m, $count) andthen @m = rotate-matrix @m while $count < $n²;
    return normalize @m;
}
