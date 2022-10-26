unit module SpaceAge;

constant %planets = (
    :Mercury(0.2408467),
    :Venus(0.61519726),
    :Earth(1),
    :Mars(1.8808158),
    :Jupiter(11.862615),
    :Saturn(29.447498),
    :Uranus(84.016846),
    :Neptune(164.79132),
);

sub age-on ( :$planet, :$seconds ) is export {
    die 'not a planet' if %planets{$planet}:!exists;
    round $seconds / 60 / 60 / 24 / 365.25 / %planets{$planet}: 0.01;
}
