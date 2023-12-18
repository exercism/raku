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

sub allergic-to( :$item, :$score ) is export {
}

sub list-allergies($score) is export {
}
