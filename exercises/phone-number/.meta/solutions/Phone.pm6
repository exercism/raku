unit module Phone;

sub clean-number ($number is copy) is export {
  $number ~~ s:g/<:!Nd>//;
  $number ~~ /^ 1? ( [ <[2..9]> <:Nd> ** 2 ] ** 2 <:Nd> ** 4 ) $/ ?? ~$0 !! Nil;
}
