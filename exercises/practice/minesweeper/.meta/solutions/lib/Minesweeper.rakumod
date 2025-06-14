unit module Minesweeper;

sub demine (@board, @near = cross -1..1, -1..1) of Array() is export {
  return @board if @board eq [];
  my @coords[@board.elems;@board.head.chars] = gather take [.comb] for @board;
  for ^@coords.shape.head X ^@coords.shape.tail -> ($x,$y) {
    next unless @coords[$x;$y] eq '*';
    for @near.map: {.head+$x, .tail+$y} {
      @coords[.head;.tail] += 1 if try defined @coords[.head;.tail].Numeric
    }
  }
  @coords.rotor(@coords.shape.tail).map: *.join
}
