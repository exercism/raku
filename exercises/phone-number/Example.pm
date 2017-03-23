unit module Phone:ver<1>;

sub clean-number ($number is copy) is export {
  $number ~~ /<:L>/ ?? return Nil !! $number ~~ s:g/<:!Nd>//;
  $number ~~ /^ 1? (<:Nd> ** 10) $/ ?? ~$0 !! Nil;
}
