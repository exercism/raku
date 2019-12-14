unit module Allergies;

constant %allergens = (
    eggs         => 0b1,
    peanuts      => 0b10,
    shellfish    => 0b100,
    strawberries => 0b1000,
    tomatoes     => 0b10000,
    chocolate    => 0b100000,
    pollen       => 0b1000000,
    cats         => 0b10000000,
);

sub allergic-to( :$item, :$score ) is export {
}

sub list-allergies($score) is export {
}
