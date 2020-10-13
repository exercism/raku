unit module RNA;

sub to-rna ($dna) is export {
  $dna.trans(<A G C T> => <U C G A>);
}
