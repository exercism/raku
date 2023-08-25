unit module Darts;

sub score-dart is export {
    given sqrt $:x² + $:y² {
        when 0  ..  1 { 10 }
        when 1 ^..  5 {  5 }
        when 5 ^.. 10 {  1 }
        default       {  0 }
    }
}
