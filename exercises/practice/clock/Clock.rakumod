unit class Clock;

has $.hour;
has $.minute;

method time {}

method add (:$minutes --> Clock) {
    return self;
}

method subtract (:$minutes --> Clock) {
    return self;
}

submethod TWEAK {
    # Can be used to modify attributes after object construction
}
