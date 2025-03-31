unit module RailFenceCipher;

sub index-map ($len, $rails, @rect=[], @indexes = [...] (0, $rails.pred).Slip xx $len div $rails){
  @rect[ $_ ; @indexes[$_] ] = $_ for ^$len;
  grep Int, flat roundrobin @rect.List;
}
sub invert-map { @_.pairs.sort( *.value ).map: *.key }
sub zigzag-encode ( $plain-text, $rails ) is export {
  join '', grep Str, flat roundrobin $plain-text.comb[ index-map( $plain-text.chars, $rails) ]
}
sub zigzag-decode ( $cipher-text, $rails ) is export {
  $cipher-text.comb[ invert-map index-map($cipher-text.chars, $rails) ].join
}
