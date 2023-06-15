sub transpose ($text) is export {
  my @matrix;

  for $text.lines.pairs
  -> $line {
      @matrix[ .key ; $line.key ] = .value for $line.value.comb.pairs
  }

  return @matrix.deepmap( { .defined ?? $_ !! ' ' } ).map( *.join ).join: "\n";
}
