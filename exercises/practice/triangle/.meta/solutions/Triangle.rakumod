unit module Triangle;

sub is-triangle ($a, $b, $c) {
  return False if so 0 == all $a, $b, $c;
  return False unless $a + $b >= $c
                   && $b + $c >= $a
                   && $a + $c >= $b;
  return True;
}

sub is-equilateral ($a, $b, $c) is export {
  return is-triangle($a, $b, $c) && [==] $a, $b, $c;
}

sub is-isosceles ($a, $b, $c) is export {
  return is-triangle($a, $b, $c) && ( is-equilateral($a, $b, $c) || ! is-scalene($a, $b, $c) );
}

sub is-scalene ($a, $b, $c) is export {
  return is-triangle($a, $b, $c) && [!=] $a, $b, $c, $a;
 }
