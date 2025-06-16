unit module Minesweeper;

sub mark-mines (@board, @near = cross -1..1, -1..1) of Array() is export {
  return @board if @board eq [];
  my @coords[@board.elems;@board.head.chars] = gather take [.comb] for @board;
  for map *.key, grep *.value eq '*', pairs @coords -> ($x,$y) {
    for @near.map: {.head+$x, .tail+$y} {
      @coords[.head;.tail] += 1 if try defined @coords[.head;.tail].Numeric
    }
  }
  .batch(.shape.tail).map: *.join with @coords
}
