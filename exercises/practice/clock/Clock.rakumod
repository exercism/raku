unit class Clock;

has $.hour;
has $.minute;

method time {!!!}

method add (:$minutes) {!!!}

method subtract (:$minutes) {!!!}

submethod TWEAK {
    # Can be used to modify attributes after object construction
}
