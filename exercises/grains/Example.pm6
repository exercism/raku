unit module Grains:ver<2>;

sub grains-on-square ($number) is export {
  die if $number < 1 or $number > 64;
  2**($number-1);
}

sub total-grains is export {
  my Int $total;
  for  1..64 { $total += grains-on-square($_) }
  $total;
}
