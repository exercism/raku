use v6;

class X::Phone::Invalid is Exception {
  has $.payload;
  method message {"'$!payload' is not valid."}
}

class Phone is export {
  has $.number;

  method new (:$number!) {
    my $validated = $number;
    $validated ~~ s:g/<:!Decimal_Number>//;
    $validated ~~ /^ 1? (\d ** 10) $/ ?? ($validated = ~$0) !! X::Phone::Invalid.new(payload => $number).throw;
    self.bless(number => $validated);
  }

  method area-code {
    $!number ~~ /\d**3/ and return ~$/;
  }

  method pretty {
    $!number ~~ /
      $<area-code> = \d**3
      $<central-office-code> = \d**3
      $<station-number> = \d**4
    / and return "($<area-code>) $<central-office-code>-$<station-number>";
  }
}

