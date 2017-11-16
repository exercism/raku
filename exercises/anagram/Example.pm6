unit module Anagram:ver<2>;

sub match-anagrams ( :$subject!, :@candidates! ) is export {
  given $subject.uc -> $ucs {
    @candidates.grep: { given .uc {$_ ne $ucs && .comb ~~ $ucs.comb.Bag} }
  }
}
