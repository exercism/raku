unit module Yacht;

sub score ( @dice, $category --> Int ) is export {
  given $category {
      when    'choice'          { @dice.sum                                        }
      when    'ones'            { @dice.grep( 1 ).sum                              }
      when    'twos'            { @dice.grep( 2 ).sum                              }
      when    'threes'          { @dice.grep( 3 ).sum                              }
      when    'fours'           { @dice.grep( 4 ).sum                              }
      when    'fives'           { @dice.grep( 5 ).sum                              }
      when    'sixes'           { @dice.grep( 6 ).sum                              }
      when    'full house'      { @dice.Bag.values (==) ( 2, 3 ) ?? @dice.sum !! 0 }
      when    'four of a kind'  { @dice.Bag.first( *.value >= 4 ).key * 4     // 0 }
      when    'little straight' { @dice.Bag ~~ (1,2,3,4,5).Bag ?? 30          !! 0 }
      when    'big straight'    { @dice.Bag ~~ (2,3,4,5,6).Bag ?? 30          !! 0 }
      when    'yacht'           { ( [==] @dice ) ?? 50                        !! 0 }
      default                   { 0                                                }
  }
}
