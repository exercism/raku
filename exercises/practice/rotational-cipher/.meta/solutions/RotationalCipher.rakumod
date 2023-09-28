unit module RotationalCipher;

sub caesar-cipher ( Str :$text, Int :$shift-key --> Str ) is export {
  $text.trans( 'A'..'Z' => rotate ( 'A'..'Z' ).Slip, $shift-key )
          .trans: 'a'..'z' => rotate ( 'a'..'z' ).Slip, $shift-key;
}
