unit module Minesweeper;

sub demine (@board, @near = cross -1..1, -1..1) of Array() is export {
  .return unless .defined and $_ ne '' given @board;
  @board = gather take [.comb] for @board;
  for ^@board.elems X ^@board.head.elems -> ($x,$y) {
    next unless @board[$x;$y] eq '*';
    for @near.map: {.head+$x, .tail+$y} {
      next unless .head ∈ ^@board.elems and .tail ∈ ^@board.head.elems;
      $_ += 1 unless $_ eq '*' given @board[.head;.tail];
    }
  }
  @board.map: *.join;
}
