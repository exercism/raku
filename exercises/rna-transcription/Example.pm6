unit module RNA:ver<1>;

sub to-rna ($dna) is export {
  fail if $dna ~~ /<-[AGCT]>/;
  $dna.trans(<A G C T> => <U C G A>);
}
