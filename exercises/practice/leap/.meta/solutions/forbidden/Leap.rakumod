unit module Leap;

sub is-leap-year ($year) is export {
    ? try Date.new(:$year, :month(2), :day(29));
}
