unit module Diamond;

sub diamond ( $letter where 'A' .. 'Z' ) is export {
    my $r = 'A' .. $letter;
    my $c = $r.elems - 1;

    my @lines = map { $_  ~ .flip.substr(1) }, $r.kv.map: -> $i, $l {
            ( ' ' x $c-$i ) ~ $l ~
            ( ' ' x    $i )
    };

    return join "\n", flat @lines, |@lines.reverse.skip;
}
