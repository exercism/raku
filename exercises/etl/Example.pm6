unit module ETL:ver<1>;

no precompilation;

sub transform ( Hash[Array[Str:D], Int:D] $_ --> Hash[Int:D, Str:D] ) is export {
  Hash[Int:D, Str:D].new: .invert».&{ .key.lc => .value }
}
