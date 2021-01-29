unit module Acronym;

sub abbreviate ($phrase) is export {
  [~] $phrase.uc.comb(/<[A..Z']>+/).map: *.substr(0, 1);
}
