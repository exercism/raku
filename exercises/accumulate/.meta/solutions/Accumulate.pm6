unit module Accumulate;

sub accumulate ( @list, &function --> Array(Iterable) ) is export {
  do .&function for @list;
}
