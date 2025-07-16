unit module SaddlePoints;

multi saddle-points ( [ [], ] ) is export { [] }
multi saddle-points ( @matrix ) of Array() {
  my @row-max = map *.max,     @matrix;
  my @col-min = map *.min, [Z] @matrix;
  my @coords[ .elems ; .head.elems ] = $_ with @matrix;    
  gather for @coords.pairs {
      next if @matrix.head.end and .value != @row-max[ .key.head ];
      next if @matrix     .end and .value != @col-min[ .key.tail ];
      take [ .key.map: *.succ ]
  }
}
