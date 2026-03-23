unit module SpiralMatrix;

sub fill-row (@m, $count is rw) {
  with @m.pairs.first( Any (elem) *.value ).key -> $row {
    @m[$row][$_] = $count++ unless @m[$row][$_] for ^@m.elems;
  }
  @m = reverse map *.Array, [Z] @m;
}
sub spiral-matrix ($n) is export {
  return [] if $n == 0;
  my ($count, @m) = 1, |[[Any xx $n] xx $n];
  fill-row @m, $count until $count > $n² and @m[0][0] == 1;
  return @m;
}
