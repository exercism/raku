unit module ParallelLetterFrequency;

sub letter-frequencies (+@texts) is export {
    return @texts
      .race( :batch(2) )
      .map( *.lc.comb(/<:L>/).Slip )
      .Bag;
}
