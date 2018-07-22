unit module Accumulate;

sub accumulate (@list, $function) is export {
  my @accumulated;
  for @list -> $element {
    @accumulated.push: $function($element);
  }
  return @accumulated;
}
