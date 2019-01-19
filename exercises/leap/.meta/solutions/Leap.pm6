unit module Leap;

sub is-leap-year ($year) is export {
  $year %% 4 && $year !%% 100 || $year %% 400;
}
