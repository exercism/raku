unit module PascalsTriangle;

sub pascals-triangle ( $rows ) is export {
  [ 1 ], { [ 0, .Slip Z+ .Slip, 0 ] } ... * andthen
  .[ ^ $rows ]
}
