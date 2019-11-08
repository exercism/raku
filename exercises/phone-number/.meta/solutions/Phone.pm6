unit module Phone;

enum Error «
   '11 digits must start with 1'
   'more than 11 digits'
   'incorrect number of digits'
   'letters not permitted'
   'punctuations not permitted'
   'area code cannot start with zero'
   'area code cannot start with one'
   'exchange code cannot start with zero'
   'exchange code cannot start with one'
»;

sub clean-number ($input) is export {
  number-is-valid( $input.trans( / <[\ .()+-]> / => '' ).comb.List );
}

sub number-is-valid ($_) {
  when .elems == 11 {
    when .[0] ≠ 1 { die Error(0) }
    default { number-is-valid(.[1..*]) }
  }

  when .elems > 11         { die Error(1) }
  when .elems ≠ 10         { die Error(2) }
  when .any ~~ /<:letter>/ { die Error(3) }
  when .any ~~ /<-alnum>/  { die Error(4) }
  when .[0] == 0           { die Error(5) }
  when .[0] == 1           { die Error(6) }
  when .[3] == 0           { die Error(7) }
  when .[3] == 1           { die Error(8) }

  default { .join }
}
