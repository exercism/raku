unit module Accumulate;

sub accumulate ( @list, &function --> List() ) is export {
    do .&function for @list;
}
