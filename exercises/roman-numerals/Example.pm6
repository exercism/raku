unit module RomanNumerals:ver<1>;


my %table{Int} = <1000 900 500 400 100 90 50 40 10 9 5 4 1>
                 Z=>
                 <M CM D CD C XC L XL X IX V IV I>;

sub to-roman ($number is copy) is export {
  [~] gather {
    for %table.keys.sort.reverse -> $k {
      if (my $repeat = $number div $k) {
        $number -= $k * $repeat;
        take %table{$k} x $repeat;
      }
    }
  }
}
