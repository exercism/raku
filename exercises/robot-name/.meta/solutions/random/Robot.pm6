unit class Robot;

our $test-all-names = False;

subset Name of Str where * ~~ /^<[A..Z]>**2 <[0..9]>**3$/;
has Name:D $!name = self.reset-name;

method name { $!name }

method reset-name {
  state Bool:D %record{Name:D};
  given self!random-name {
    when %record{$_} {
      return self.reset-name;
    }
    default {
      %record{$_} = True;
      return $!name = $_;
    }
  }
}

method !random-name {
  ( ('A'..'Z').roll(2), (^10).roll(3) ).flat.join;
}
