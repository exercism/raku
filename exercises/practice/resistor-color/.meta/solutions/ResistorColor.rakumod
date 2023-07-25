unit module ResistorColor;

constant @colors = <black brown red orange yellow green blue violet grey white>;

sub all-colors is export {
    @colors
}

sub color-code ( $color ) is export {
    @colors.pairs.first( { .value eq $color } ).key
}
