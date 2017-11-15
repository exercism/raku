unit module SpaceAge;

role Planet {
  method age-on ($seconds) {
    ($seconds / self.orbital-period).round(0.01);
  }
}

class Earth does Planet is export {
  my $.orbital-period = 31557600;
}

my %planets = (
  :Mercury(0.2408467),
  :Venus(0.61519726),
  :Mars(1.8808158),
  :Jupiter(11.862615),
  :Saturn(29.447498),
  :Uranus(84.016846),
  :Neptune(164.79132),
);
for %planets.kv -> $planet, $relative {
  use MONKEY-SEE-NO-EVAL;
  OUR::EXPORT::ALL::{$planet} := OUR::EXPORT::DEFAULT::{$planet} := EVAL "class $planet does Planet is export " ~
  '{ my $.orbital-period = calculate-orbital-period $relative }';
}

sub calculate-orbital-period ($relative-to-earth) {
  Earth.orbital-period * $relative-to-earth;
}
