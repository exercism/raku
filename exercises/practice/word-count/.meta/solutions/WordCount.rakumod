unit module WordCount;

sub count-words (Str:D $str --> Bag:D) is export {
  $str.lc.comb(/ <alnum>+ (\'<alnum>+)? /).Bag;
}
