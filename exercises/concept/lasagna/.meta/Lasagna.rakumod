unit module Lasagna;

our constant $EXPECTED-MINUTES-IN-OVEN = 40;
my  constant $LAYER-PREP-TIME          = 2;

sub remaining-minutes-in-oven ($actual-minutes-in-oven) is export {
    return $EXPECTED-MINUTES-IN-OVEN - $actual-minutes-in-oven;
}

sub preparation-time-in-minutes ($number-of-layers) is export {
    return $LAYER-PREP-TIME * $number-of-layers;
}

sub total-time-in-minutes ( $number-of-layers, $actual-minutes-in-oven ) is export {
    return preparation-time-in-minutes($number-of-layers) + $actual-minutes-in-oven;
}

sub oven-alarm () is export {
    return ｢Ding!｣;
}
