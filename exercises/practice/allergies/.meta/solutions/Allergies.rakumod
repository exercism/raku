unit module Allergies;

enum Allergen is export <
    Eggs
    Peanuts
    Shellfish
    Strawberries
    Tomatoes
    Chocolate
    Pollen
    Cats
>;

sub allergic-to(
    Allergen(UInt) :$item,
    UInt:D :$score,
    --> Bool
) is export {
    so (2 ** $item) +& $score;
}

sub list-allergies( UInt:D $score --> Set() ) is export {
    Allergen.values.map( { allergic-to(:$score, :$^item) ?? Allergen($item) !! Empty } );
}
