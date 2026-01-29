unit class RationalNumbers;

has Int $.a;
has Int $.b;

method reduce {
  ($!a, $!b) Xdiv= $!a gcd $!b;
  ($!a, $!b)     = -$!a, $!b.abs if $!b < 0;
  self;
}

submethod TWEAK {
  self.reduce;
}

method add (RationalNumbers $foo) {
  given $!b lcm $foo.b -> $lcm {
    $!a = ($lcm div $!b)*$!a + ($lcm div $foo.b)*$foo.a;
    $!b =  $lcm;
  }
  self.reduce;
}

method subtract (RationalNumbers $foo) {
  self.add( RationalNumbers.new( a => -$foo.a, b => $foo.b ) )
      .reduce;
}

method multiply (RationalNumbers $foo) {
  ($!a, $!b) Z*= $foo.a, $foo.b;
  self.reduce;
}

method divide (RationalNumbers $foo) {
  self.multiply( RationalNumbers.new( a => $foo.b, b => $foo.a ) )
      .reduce;
}

method absolute {
  ($!a, $!b) .= map( *.abs );
  self.reduce;
}

method exponent ($power) {
  ($!a, $!b) = ($!b, $!a) if $power < 0;
  ($!a, $!b) X**= $power.abs;
  self.reduce;
}

method base ($base) {
  $base**( $!a/$!b );
}
