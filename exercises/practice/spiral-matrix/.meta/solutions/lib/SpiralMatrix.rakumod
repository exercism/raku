unit module SpiralMatrix;

sub fill-turn ($row, $step is rw, @m) {
  @m[$row;$_] = $step++ unless @m[$row;$_] for ^@m;
  @m          = [R,] [Z] @m;
}
sub spiral-matrix (\n) is export {
  my ($row, $step, @m) = 0, 1, |[[Any xx n] xx n];
  fill-turn $row++/4, $step, @m until $step>n² && @m[0;0] == 1|[];
  return @m;
}
