unit module Minesweeper;

sub demine (@board) is export {
  return @board unless @board.defined and @board ne "";
  my @sboard[ .elems ; .head.chars ] = .map: *.comb with @board;
  my @offsets = grep * !eqv (0,0), (-1..1 X -1..1);
  for ^@sboard.shape.head X ^@sboard.shape.tail
  -> ($x, $y) {
    next unless @sboard[ $x ; $y ] eq ' ';
    given gather for @offsets.map: { .head + $x, .tail + $y } {
      take try @sboard[ .head ; .tail ]
    } {
      given .Bag< * > {
        next when 0;
        default { @sboard[ $x ; $y ] = $_  }
      }
    }
  }
  return Array.new: comb @board.head.chars, join '', gather .take for @sboard
}
