unit module Say;

constant %single = 0 => Empty, ( 1.. 9 Z=> <one two three four five six seven eight nine> );
constant %tenty  =              10..19 Z=> <ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen>;
constant %tens   =     (20, 30 ... * ) Z=> <twenty thirty forty fifty sixty seventy eighty ninety>;
constant %zero2ninety-nine =
  |%single.sort.skip,
  |%tenty,
  |(%tens X %single).map: {.head.key + .tail.key => join '-', .head.value, .tail.value};

multi hundreds (    0 ) { '' }
multi hundreds ( $num ) {
  $num.chars == 3
  ?? %zero2ninety-nine{ $num.comb.head } ~ ' hundred ' ~ hundreds $num.substr(1).Int
  !! %zero2ninety-nine{ $num }
}

multi utter ( 0 ) is export { 'zero' }
multi utter ( $num where 1..^1e12 ) {
  trim join ' ', reverse gather
    .take if .head
  for $num.flip.comb(3).map( { hundreds .flip.Int } ) Z << '' thousand million billion >>;
}
