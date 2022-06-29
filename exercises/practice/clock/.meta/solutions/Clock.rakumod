unit class Clock;

has Int:D $.hour   = 0;
has Int:D $.minute = 0;

method time {
    sprintf '%02d:%02d', self.hour, self.minute;
}

method add (Int:D :$minutes --> Clock) {
    $!minute += $minutes;
    self.TWEAK;
    return self;
}

method subtract (Int:D :$minutes --> Clock) {
    self.add(minutes => -$minutes);
}

submethod TWEAK {
    $!hour = ($!hour + $!minute div 60) % 24;
    $!minute %= 60;
}
