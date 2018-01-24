unit module Accumulate:ver<2>;

sub accumulate (@list, $function) is export {
  my @accumulated;
  for @list -> $element {
    @accumulated.push: $function($element);
  }
  return @accumulated;
}
