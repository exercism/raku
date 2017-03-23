unit module Anagram:ver<1>;

sub match-anagrams ($word, @words) is export {
  my @results;
  my $canonical = canonize($word);
  for @words -> $w {
    next if $w.lc eq $word.lc;
    my $try = canonize($w);
    if $try eq $canonical {
      @results.push: $w;
    }
  }
  @results;
}

sub canonize ($str) {
  (($str.lc.split('')).sort).join('');
}
