unit class Robot;

our $test-all-names = True;

my $promised-names = start [pick ([X~] |(("A".."Z") xx 2), |(^10 xx 3)): *];

subset Name of Str where * ~~ /^<[A..Z]>**2 <[0..9]>**3$/;
has Name:D $.name = self.reset-name;

method reset-name {
  await $promised-names;
  given $promised-names.result[$++] {
    when Str {
      return $!name = $_;
    }
  }
  die 'All names used.';
}
