unit module EliudsEggs;

sub count-eggs ( $display ) is export {
  $display.base( 2 ).comb.Bag{ '1' };
}
