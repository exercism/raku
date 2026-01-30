unit module ComplexNumbers;

sub prefix:<Re> (Complex $op) is export { $op.re } # real part
sub prefix:<Im> (Complex $op) is export { $op.im } # imaginary part
sub infix:<＋> (Numeric $left, Numeric $right) is export { $left + $right } # addition with fullwidth plus sign
sub infix:<－> (Numeric $left, Numeric $right) is export { $left - $right } # subtraction with fullwidth hyphen-minus
sub infix:<⋅> (Numeric $left, Numeric $right) is export { $left * $right } # multiplication with dot operator
sub infix:<∕> (Numeric $left, Numeric $right) is export { $left / $right } # division with division slash
sub circumfix:<｜ ｜> (Complex $op) is export { $op.abs } # absolute value with verticla line
sub postfix:<∗> (Complex $op) is export { $op.conj } # conjugate with asterisk operator
sub infix:<^> (e, Numeric $right) is export { $right.exp } # exponent with circumflex accent
