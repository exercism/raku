unit module Lasagna;

constant EXPECTED-MINUTES-IN-OVEN is export = 40;
constant LAYER-PREP-TIME = 2;

sub remaining-minutes-in-oven ($actual-minutes-in-oven) is export {
    return EXPECTED-MINUTES-IN-OVEN - $actual-minutes-in-oven;
}

sub preparation-time-in-minutes ($number-of-layers) is export {
    return $number-of-layers * LAYER-PREP-TIME;
}

sub total-time-in-minutes ( $number-of-layers, $actual-minutes-in-oven ) is export {
    return preparation-time-in-minutes($number-of-layers) + $actual-minutes-in-oven;
}

sub oven-alarm () is export {
    return ｢Ding!｣;
}
