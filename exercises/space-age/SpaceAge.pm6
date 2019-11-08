unit module SpaceAge;

role Planet {
  method age-on ($seconds) {
  }
}

class Earth does Planet is export {
  my $.orbital-period = 31557600;
}

=for comment
---
Orbital periods relative to Earth:
  Mercury: 0.2408467
  Venus: 0.61519726
  Mars: 1.8808158
  Jupiter: 11.862615
  Saturn: 29.447498
  Uranus: 84.016846
  Neptune: 164.79132
...
