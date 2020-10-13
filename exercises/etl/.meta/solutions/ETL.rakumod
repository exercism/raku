unit module ETL;

sub transform (
  Array[Str:D] %input where { .keys.all ~~ Int:D },
  --> Hash[ Int:D, Str:D ]
) is export {
  Hash[ Int:D, Str:D ].new( %input.invert.map: { .key.lc => .value } );
}
