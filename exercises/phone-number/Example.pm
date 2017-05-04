unit module Phone:ver<2>;

sub clean-number ($number is copy) is export {
  $number ~~ /<:L>/ ?? return Nil !! $number ~~ s:g/<:!Nd>//;
  $number ~~ /^ 1? ( [ <[2..9]> <:Nd> ** 2 ] ** 2 <:Nd> ** 4 ) $/ ?? ~$0 !! Nil;
}
