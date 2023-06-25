unit module KillerSudokuHelper;

sub killer-sudoku-helper ( :$sum, :$size, :$exclude ) is export {
    ( 1..9 ).combinations( $size ).grep( *.sum == $sum ).grep( *.none (elem) $exclude )
}
