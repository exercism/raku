unit module ResistorColor;

constant %colors = <black brown red orange yellow green blue violet grey white> Z=> ^10;

sub all-colors is export {
    %colors.sort( *.values ).map( *.key )
}

sub color-code ( $color ) is export {
    %colors{ $color }
}
