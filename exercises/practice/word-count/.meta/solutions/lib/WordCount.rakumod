unit module WordCount;

sub count-words (Str:D $_) is export {
    .lc.comb(/ <alnum>+ (\'<alnum>+)? /);
}
