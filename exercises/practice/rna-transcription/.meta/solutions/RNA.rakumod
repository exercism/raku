unit module RNA;

sub to-rna ($_) is export {
    .trans(<A G C T> => <U C G A>);
}
