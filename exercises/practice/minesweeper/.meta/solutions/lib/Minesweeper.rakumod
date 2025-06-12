unit module Minesweeper;

sub demine (@board) of Array() is export {
  return @board unless @board.defined and @board ne "";
  my @coord-board[ .elems ; .head.chars ] = .map: *.comb with @board;
  my @offsets = -1..1 X -1..1;
  for ^@coord-board.shape.head X ^@coord-board.shape.tail
  -> ($x, $y) {
    next unless @coord-board[ $x ; $y ] eq ' ';
    given gather for @offsets.map: { .head + $x, .tail + $y } {
      take try @coord-board[ .head ; .tail ]
    } {
      given .Bag< * > {
        next when 0;
        default { @coord-board[ $x ; $y ] = .sum  }
      }
    }
  }
  return comb @board.head.chars, join '', @coord-board
}
