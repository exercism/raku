unit module FlattenArray;

sub flatten-array(@input --> Array) is export {
  @input.&denest;
  return my @result;

  sub denest(@array) {
    for @array {
      .&denest when Array;
      @result.push: $_ when Int;
    }
  }
}
