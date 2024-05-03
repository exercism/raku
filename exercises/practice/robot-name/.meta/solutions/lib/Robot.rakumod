unit class Robot;

my $promised-names = start [pick ([X~] ("A".."Z"), |(^10 xx 2)): *];

subset Name of Str where * ~~ /^<[A..Z]> <[0..9]>**2$/;
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
