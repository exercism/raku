unit module AllYourBase:ver<4>;

sub convert-base (
  :%bases! where all(.keys ~~ <from to>.Set, .values.all > 1),
  :@digits! where %bases<from> > .all ~~ UInt:D,
  --> Array[UInt:D]
) is export {
  from-decimal %bases<to>, to-decimal(%bases<from>, @digits);
}

sub to-decimal ($input-base, @input-digits) {
  my $elems = @input-digits.elems;
  $_ == 0 ?? $elems-- !! last for @input-digits;
  (loop (my $i = 0; $i < $elems; $i++) {
    @input-digits.reverse[$i] * $input-base ** $i;
  }).sum;
}

sub from-decimal ($output-base, $num is copy) {
  my UInt:D @output-digits;
  while $num >= $output-base {
    unshift @output-digits, $num % $output-base;
    $num div= $output-base;
  }
  @output-digits.unshift: $num;
}
