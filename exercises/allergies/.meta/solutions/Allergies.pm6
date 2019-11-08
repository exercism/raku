unit module Allergies;

enum Allergens (
    <
      eggs
      peanuts
      shellfish
      strawberries
      tomatoes
      chocolate
      pollen
      cats
    > Z=> ( 1, 2, 4 … ∞ )
);

sub allergic-to(
  Str:D  :$item where * ∈ Allergens.enums.keys,
  UInt:D :$score,
  --> Bool
) is export {
  so Allergens::{$item}.value +& $score;
}

sub list-allergies( UInt:D $score ) is export {
  Allergens.enums.keys.grep( { allergic-to :$score, :$^item } );
}
