unit module ResistorColorDuo;

my constant @BANDS = < black brown red orange yellow green blue violet grey white >;
sub decoded-value ( *@colors ) is export {
  @BANDS.antipairs.Hash{ @colors[ 0 .. 1 ] }.join.Int
}
