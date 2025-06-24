unit module OcrNumbers;

sub ascii-to-digits ( $art where { .lines.elems %% 4 and .lines.map( *.chars ).all %% 3 } ) is export {
  constant $NUMBERS = q:to/0123456789/;
   _     _  _     _  _  _  _  _ 
  | |  | _| _||_||_ |_   ||_||_|
  |_|  ||_  _|  | _||_|  ||_| _|
                                 
  0123456789
  constant %LOOKUP = ^10 RZ=> ( map *.join( "\n" ), zip $NUMBERS.lines.map( *.comb ).map: *.rotor: 3 );

  join ',', gather for $art.lines.rotor: 4 {
    take join '',
    map { .defined ?? $_ !! '?' },
    %LOOKUP{
      map *.join( "\n" ), zip .map( *.comb ).map: *.rotor: 3
    }
  }
}
