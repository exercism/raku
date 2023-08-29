unit module Allergies;

enum Allergens is export <
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
    Allergens(UInt) :$item,
    UInt:D :$score,
    --> Bool
) is export {
    so (2 ** $item) +& $score;
}

sub list-allergies( UInt:D $score --> Set() ) is export {
    Allergens.values.map( { allergic-to(:$score, :$^item) ?? Allergens($item) !! Empty } );
}
