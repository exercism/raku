unit class Robot:ver<1>;

state %record;

has Str:D $.name = self.reset-name;

method reset-name {
  $!name = ('AA'..'ZZ').roll ~ ('000'..'999').roll;
  self.reset-name if %record{$!name}:exists;
  %record{$!name} = True;
  return $!name;
}
