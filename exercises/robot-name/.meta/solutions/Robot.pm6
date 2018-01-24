unit class Robot:ver<2>;

subset Name of Str where * ~~ /^<[A..Z]>**2 <[0..9]>**3$/;
has Name $.name = self.reset-name;

method reset-name {
  state Promise:D $promise = start ('AA000'..'ZZ999').pick: *;
  state Bool:D %record{Name:D};
  state Int:D $i = 0;

  if $promise.status ~~ 'Kept' {
    ($!name = $promise.result[$i++]) or die 'All names used.';
  } else {
    $!name = ('A'..'Z').roll(2).join ~ (^10).roll(3).join;
  }
  self.reset-name if %record{$!name}:exists;
  %record{$!name} = True;
  return $!name;
}
