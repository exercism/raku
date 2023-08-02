unit module ResistorColor;

constant @BANDS = <black brown red orange yellow green blue violet grey white>;

sub all-colors is export {
    @BANDS
}

sub color-code ( $color ) is export {
    @BANDS.antipairs.Hash{ $color }
}
