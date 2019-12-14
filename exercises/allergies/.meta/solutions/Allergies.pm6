unit module Allergies;

constant %allergens = <
      eggs
      peanuts
      shellfish
      strawberries
      tomatoes
      chocolate
      pollen
      cats
    > Z=> ( 1, 2, 4 … ∞ );

sub allergic-to(
  Str:D  :$item where * ∈ %allergens.keys,
  UInt:D :$score,
  --> Bool
) is export {
  so %allergens{$item} +& $score;
}

sub list-allergies( UInt:D $score ) is export {
  %allergens.keys.grep( { allergic-to :$score, :$^item } );
}
