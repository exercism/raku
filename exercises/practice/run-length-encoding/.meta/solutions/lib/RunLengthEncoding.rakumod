unit module RunLengthEncoding;

grammar RLE {
  token TOP     { <pair>+            }
  token pair    { <tally>? <element> }
  token tally   { <digit>+           }
  token element { <alpha> | ' '      }
}
class RLE::Decode {
  method TOP     ($/) { make $<pair>.map( *.made ).join               }
  method pair    ($/) { make $<element>.made x ( $<tally>.made // 1 ) }
  method tally   ($/) { make $/.Int                                   }
  method element ($/) { make $/.Str                                   }
}
sub rle-decode ($compressed) is export {
  RLE.parse( $compressed, actions => RLE::Decode ).made
}
sub rle-encode ($raw) is export {
  given $raw.comb( / ( [<digit>+]? ) [<alpha> | ' ']+ % <same> / )
     .map( { .chars == 1 ?? $_ !! .chars ~ .comb.head } )
     .join
  -> $compressed {
    fail unless $raw eq rle-decode($compressed);
    return $compressed
  }
}
