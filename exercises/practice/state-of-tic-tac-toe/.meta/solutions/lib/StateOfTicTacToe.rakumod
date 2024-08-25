unit module StateOfTicTacToe;

enum Player ( X => '100', O => '010' );
enum State is export < win draw ongoing invalid >;

constant @MASK = < 448 56 7 292 146 73 273 84 >;

multi is-win ( @board ) {
    samewith @board, piece => X | O
}

multi is-win ( @board, :$piece! ) {
    @board.join
          .map( *.trans: 'XO ' => $piece.value )
          .flat
          .map( *.parse-base: 2 )
          <<+&<< @MASK
          >>==<< @MASK
    andthen *.Bag{ True }.so;
}

sub is-invalid ( @board ) {
    is-win @board, piece => X & O or
    not 0|1 == [-] @board.map( *.comb ).Bag< X O >
}

sub is-draw ( @board ) {
    @board.join.contains( none ' ' ) and not is-win @board
}

sub state-of-tic-tac-toe ( @board ) of State is export {
    when    is-invalid @board { invalid }
    when    is-draw    @board { draw    }
    when    is-win     @board { win     }
    default                   { ongoing }
}
