unit module Isogram;

sub is-isogram (Str:D $_ --> Bool:D) is export {
    not repeated .lc.comb: / <:Letter> /
}
