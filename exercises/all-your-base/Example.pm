unit module AllYourBase:ver<2>;

class X::AllYourBase::InvalidBase is Exception {
  has $.payload;
  method message {"$!payload is not a valid base."}
}

class X::AllYourBase::InvalidDigit is Exception {
  has %.payload;
  method message {"%!payload<digit> is not a valid digit for base %!payload<base>."}
}

sub convert-base (Int:D $input-base, @input-digits, Int:D $output-base --> Array:D) is export {
  for $input-base, $output-base {
    X::AllYourBase::InvalidBase.new(payload => $_).throw if $_ < 2;
  }
  from-decimal($output-base, (to-decimal $input-base, @input-digits));
}

sub to-decimal ($input-base, @input-digits) {
  return [].Slip if !@input-digits;
  my $elems = @input-digits.elems;
  for @input-digits {
    if $_ == 0 { $elems-- }
    else { last }
  }
  my $dec = 0;
  loop (my $i = 0; $i < $elems; $i++) {
    if @input-digits.reverse[$i] < 0 || @input-digits.reverse[$i] >= $input-base {
      X::AllYourBase::InvalidDigit.new( :payload(base => $input-base, digit => @input-digits.reverse[$i]) ).throw;
    }
    $dec += @input-digits.reverse[$i] * $input-base ** $i;
  }
  return $dec;
}

sub from-decimal ($output-base, $dec) {
  my @output-digits;
  my $num = $dec;
  while $num >= $output-base {
    unshift @output-digits, $num % $output-base;
    $num div= $output-base;
  }
  unshift @output-digits, $num;
  return @output-digits;
}
