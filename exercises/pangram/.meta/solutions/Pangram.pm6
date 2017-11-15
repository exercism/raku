unit module Pangram;

sub is-pangram (Str:D $string --> Bool:D) is export {
  $string.lc.comb ⊇ ‘a’..‘z’
}
