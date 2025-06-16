unit module Minesweeper;

multi mark-mines ([  ]) { [  ] }
multi mark-mines (['']) { [''] }
multi mark-mines (@board) of Array() is export {
  my @nearby = -1..1 X -1..1;
  my @coords[.elems;.head.chars] = .map: *.comb with @board;
  for map *.key, grep *.value eq '*', pairs @coords -> ($x,$y) {
    for @nearby.map: {.head+$x, .tail+$y} -> ($x-offset,$y-offset) {
      @coords[$x-offset;$y-offset] += 1 if try defined @coords[$x-offset;$y-offset].Numeric
    }
  }
  .rotor(.shape.tail).map: *.join with @coords
}
