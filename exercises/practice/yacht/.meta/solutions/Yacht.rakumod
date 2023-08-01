unit module Yacht;

sub score ( @dice, $category ) is export {
  given $category {
      when    'choice'          { return @dice.sum           }
      when    'ones'            { return @dice.grep( 1 ).sum }
      when    'twos'            { return @dice.grep( 2 ).sum }
      when    'threes'          { return @dice.grep( 3 ).sum }
      when    'fours'           { return @dice.grep( 4 ).sum }
      when    'fives'           { return @dice.grep( 5 ).sum }
      when    'sixes'           { return @dice.grep( 6 ).sum }
      when    'full house'      { return @dice.Bag.values.sort ~~ ( 2,3 ) ?? @dice.sum        !! 0 }
      when    'four of a kind'  { return @dice.Bag.first( *.value >= 4 ).key * 4              // 0 }
      when    'little straight' { return @dice.Bag ~~ (1,2,3,4,5).Bag ?? 30                   !! 0 }
      when    'big straight'    { return @dice.Bag ~~ (2,3,4,5,6).Bag ?? 30                   !! 0 }
      when    'yacht'           { return ( [==] @dice ) ?? 50                                 !! 0 }
      default                   { return 0                                                         }
  }
}
