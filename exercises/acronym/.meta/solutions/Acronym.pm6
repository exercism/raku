unit module Acronym:ver<2>;

sub abbreviate ($phrase) is export {
  [~] $phrase.uc.comb(/\w+/).map: *.substr(0, 1);
}
