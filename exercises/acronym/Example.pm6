unit module Acronym:ver<1>;

sub abbreviate ($phrase) is export {
  [~] $phrase.uc.comb(/\w+/).map: *.substr(0, 1);
}
