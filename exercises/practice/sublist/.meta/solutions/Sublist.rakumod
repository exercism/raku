unit module Sublist;

sub compare-lists ( $a, $b ) is export {
  return 'equal'     when $a eqv $b;
  return 'superlist' when $b eqv ()
    || $a.rotor( $b.elems => - $b.elems.pred ).any eqv $b;
  return 'sublist'   when $a eqv ()
    || $b.rotor( $a.elems => - $a.elems.pred ).any eqv $a;
  return 'unequal';
}
