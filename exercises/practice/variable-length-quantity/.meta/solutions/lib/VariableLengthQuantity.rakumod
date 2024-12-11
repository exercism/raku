unit module VariableLengthQuantity;

grammar VLQ {
  token TOP     { <train> +                                     }
  token train   { [ [ <coupled> <cargo> ]+ ]? <caboose> <cargo> }
  token cargo   { [ 0 | 1 ] ** 7                                }
  token coupled { 1                                             }
  token caboose { 0                                             }
}

class VLQ::Decode {
  method TOP ($/)   { make Array.new: map *.made, $<train>           }
  method train ($/) { make $<cargo>.map( *.made ).join.parse-base: 2 }
  method cargo ($/) { make map *.Str, $/                             }
}

sub encode-vlq (@raw --> Array()) is export {
  given flat gather
    take .[^.end].map( * +| 0b10000000 ), .[.end]
  for @raw.map: *.base(2).flip.comb(7).flip.words.map: *.parse-base: 2
  -> @compressed {
    fail unless @raw eqv VLQ.parse(
      actions => VLQ::Decode,
      @compressed.map( *.base(2).fmt: '%08d' ).join
    ).made;
    return @compressed;
  }
}

sub decode-vlq (@compressed --> Array()) is export {
  VLQ.parse(
    actions => VLQ::Decode,
    @compressed.map( *.base( 2 ).fmt: '%08d' ).join
  ).made // fail
}
