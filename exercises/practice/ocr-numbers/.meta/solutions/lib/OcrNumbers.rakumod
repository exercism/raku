unit module OcrNumbers;

my role X::OCR is Exception {}
my class X::OCR::Invalid-Lines does X::OCR {
    method message { 'Number of input lines is not a multiple of four' }
}
my class X::OCR::Invalid-Columns does X::OCR {
    method message { 'Number of input columns is not a multiple of three' }
}
multi ascii-to-digits ( $art where .lines.elems !%% 4 ) is export {
  X::OCR::Invalid-Lines.new.throw
}
multi ascii-to-digits ( $art where .lines.map( *.chars ).any !%% 3 ) is export {
  X::OCR::Invalid-Columns.new.throw
}
multi ascii-to-digits ( $art ) is export {
  constant $NUMBERS = q:to/END/;
   _     _  _     _  _  _  _  _ 
  | |  | _| _||_||_ |_   ||_||_|
  |_|  ||_  _|  | _||_|  ||_| _|
                                 
  END
  constant %LOOKUP = ^10 RZ=> ( map *.join( "\n" ), zip $NUMBERS.lines.map( *.comb ).map: *.rotor: 3 );

  join ',', gather for $art.lines.rotor: 4 {
    take join '',
    map { .defined ?? $_ !! '?' },
    %LOOKUP{
      map *.join( "\n" ), zip .map( *.comb ).map: *.rotor: 3
    }
  }
}
