unit module Triangle;

sub is-triangle ($a, $b, $c) {
  return False if so 0 == all $a, $b, $c;
  return $a + $b >= $c
      && $b + $c >= $a
      && $a + $c >= $b;
}

sub is-equilateral ($a, $b, $c) is export {
  return is-triangle $a, $b, $c && [==] $a, $b, $c;
}

sub is-isosceles ( *@_ ) is export {
  return .&is-triangle && .&is-equilateral || ! .&is-scalene;
}

sub is-scalene ($a, $b, $c) is export {
  return is-triangle $a, $b, $c && [!=] $a, $b, $c;
 }
