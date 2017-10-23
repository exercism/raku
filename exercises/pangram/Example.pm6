unit module Pangram:ver<1>;

sub is-pangram (Str:D $string --> Bool:D) is export {
  $string.lc.comb ⊇ ‘a’..‘z’
}
