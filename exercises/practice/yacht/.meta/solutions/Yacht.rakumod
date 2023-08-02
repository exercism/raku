unit module Yacht;

sub score ( $dice, *%category --> Int ) is export {
  given %category {
      when    *.<choice>          { $dice.kxxv.sum }

      when    *.<ones>            { $dice{1}     }
      when    *.<twos>            { $dice{2} * 2 }
      when    *.<threes>          { $dice{3} * 3 }
      when    *.<fours>           { $dice{4} * 4 }
      when    *.<fives>           { $dice{5} * 5 }
      when    *.<sixes>           { $dice{6} * 6 }

      when    *.<yacht>           { $dice.keys == 1           ?? 50 !! 0 }
      when    *.<little-straight> { $dice (==) ( 1 .. 5 ).Bag ?? 30 !! 0 }
      when    *.<big-straight>    { $dice (==) ( 2 .. 6 ).Bag ?? 30 !! 0 }

      when    *.<four-of-a-kind>  { with $dice.first( *.value >= 4 ) { .key * 4 } else { 0 } }
      when    *.<full-house>      { $dice.values (==) ( 2, 3 ) ?? $dice.kxxv.sum !! 0 }

      default                     { 0 }
  }
}
