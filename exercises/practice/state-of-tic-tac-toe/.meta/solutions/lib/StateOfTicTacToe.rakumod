unit module StateOfTicTacToe;

enum Player < X O >;
enum State is export < win draw ongoing invalid >;

multi can-win ( @board ) {
    samewith @board, piece => X | O
}

multi can-win ( @board, :$piece! ) {
    $piece x 3 ∈ flat @board,
    @board.map( *.comb ).reduce( &[Z~] ),
    map *.join, .[0,4,8], .[2,4,6] with @board.join.comb
}

sub is-invalid ( @board ) {
    can-win @board, piece => X & O or
    not 0|1 == [-] @board.join.comb.Bag< X O >
}

sub has-drawn ( @board ) {
    @board.join.contains: none ' ' and not can-win @board
}

sub state-of-tic-tac-toe ( @board ) of State is export {
    when    is-invalid @board { invalid }
    when    has-drawn  @board { draw    }
    when    can-win    @board { win     }
    default                   { ongoing }
}
