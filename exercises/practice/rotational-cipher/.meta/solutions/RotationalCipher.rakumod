unit module RotationalCipher;

sub caesar-cipher ( Str $message, Int $shift-key --> Str ) is export {
  $message.trans( 'A'..'Z' => rotate ( 'A'..'Z' ).Slip, $shift-key )
          .trans: 'a'..'z' => rotate ( 'a'..'z' ).Slip, $shift-key;
}
