my role X::NucleotideCount is Exception {}

my class X::NucleotideCount::InvalidNucleotide does X::NucleotideCount {
  method message {
    'Invalid nucleotide in strand';
  }
}

module NucleotideCount {
  multi nucleotide-count (
    Str:D $_ where { .comb.Set ⊆ <A C G T> },
    --> Bag(Iterable:D)
  ) is export {
    .comb;
  }

  multi nucleotide-count (
    Str:D $_,
    --> Nil
  ) {
    X::NucleotideCount::InvalidNucleotide.new.throw;
  }
}
