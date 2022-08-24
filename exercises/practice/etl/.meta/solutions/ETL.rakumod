unit module ETL;

sub transform ( %input --> Hash[ Int:D, Str:D ] ) is export {
    Hash[ Int:D, Str:D ].new( %input.invert.map: { (.key.lc, .value).Slip } );
}
