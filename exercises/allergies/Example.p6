our @allergens = <
    eggs
    peanuts
    shellfish
    strawberries
    tomatoes
    chocolate
    pollen
    cats
>;

sub allergic-to($code,$substance) is export {
    return so $code +& ( 2 ** @allergens.first({ $_ eq $substance},:k) ) 
}

sub list-allergies($code) is export {
    return grep { allergic-to($code,$_) }, @allergens;
}
