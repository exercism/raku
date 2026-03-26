unit module SpiralMatrix;

sub fill-rotate ($row, $count is rw, @m) {
  @m[$row;$_] = $count++ unless @m[$row;$_] for ^@m;
  @m = reverse map *.Array, [Z] @m;
}
multi spiral-matrix ( 0) is export { [] }
multi spiral-matrix ($n) {
  my ($row, $count, @m) = 0, 1, |[[Any xx $n] xx $n];
  fill-rotate $row++ div 4, $count, @m until $count > $n² and @m[0;0] == 1;
  return @m;
}
