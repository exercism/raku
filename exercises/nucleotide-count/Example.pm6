unit module NucleotideCount:ver<2>;

sub nucleotide-count (
  Str:D $_ where { .comb.Set ⊆ <A C G T> } --> Bag(Iterable:D)
) is export {
  .comb
}
