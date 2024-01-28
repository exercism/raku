unit module Triangle;

sub is-triangle ($a, $b, $c) {
      $a + $b >= $c
  and $b + $c >= $a
  and $a + $c >= $b
  and not 0 == all $a, $b, $c
}

sub is-equilateral ($a, $b, $c) is export {
  is-triangle($a, $b, $c) and 1 == unique $a, $b, $c
}

sub is-isosceles ($a, $b, $c) is export {
  is-triangle($a, $b, $c) and 2 >= unique $a, $b, $c
}

sub is-scalene ($a, $b, $c) is export {
  is-triangle($a, $b, $c) and 3 == unique $a, $b, $c
}
