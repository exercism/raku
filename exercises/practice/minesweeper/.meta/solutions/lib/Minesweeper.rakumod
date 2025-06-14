unit module Minesweeper;

sub demine (@board, @offsets = cross -1..1, -1..1) of Array() is export {
  return @board unless @board.defined and @board ne "";
  my @coords = gather take [.comb] for @board;
  for ^@coords.elems X ^@coords.head.elems -> ($x, $y) {
    next unless @coords[$x][$y] eq '*';
    for @offsets.map: {.head+$x, .tail+$y} {
      next unless .head ∈ ^@coords.elems and .tail ∈ ^@coords.head.elems;
      @coords[.head][.tail] += 1 unless @coords[.head][.tail] eq '*';
    }
  }
  return @coords.map: *.join;
}
