unit module Leap:ver<1>; 

sub is-leap-year ($year) is export {
  is-divisible($year, 400)
    || is-divisible($year, 4)
    && !is-divisible($year, 100);
}

sub is-divisible($year, $number) {
  $year % $number == 0 ?? True !! False;
}
