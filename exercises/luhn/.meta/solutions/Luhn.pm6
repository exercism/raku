unit module Luhn;

sub is-luhn-valid ($input is copy) is export {
  $input ~~ s:g/\s+//;
  return False if $input.chars < 2 || $input ~~ /\D/;
  my @num = $input.split('', :skip-empty);
  @num.unshift: 0 if @num % 2;
  my $sum;
  for @num -> $a, $b {
    $sum += $a * 2;
    $sum -= 9 if $a * 2 > 9;
    $sum += $b;
  }
  return ($sum %% 10).so;
}
