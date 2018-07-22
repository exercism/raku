unit module NucleotideCount;

sub nucleotide-count (
  Str:D $_ where { .comb.Set ⊆ <A C G T> } --> Bag(Iterable:D)
) is export {
  .comb
}
