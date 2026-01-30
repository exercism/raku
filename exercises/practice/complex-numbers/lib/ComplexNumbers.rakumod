unit module ComplexNumbers;

sub prefix:<Re> (Complex $op) is export { } # real part
sub prefix:<Im> (Complex $op) is export { } # imaginary part
sub infix:<＋> (Numeric $left, Numeric $right) is export { } # addition with fullwidth plus sign
sub infix:<－> (Numeric $left, Numeric $right) is export { } # subtraction with fullwidth hyphen-minus
sub infix:<⋅> (Numeric $left, Numeric $right) is export { } # multiplication with dot operator
sub infix:<∕> (Numeric $left, Numeric $right) is export { } # division with division slash
sub circumfix:<｜ ｜> (Complex $op) is export { } # absolute value with verticla line
sub postfix:<∗> (Complex $op) is export { } # conjugate with asterisk operator
sub infix:<^> (e, Numeric $right) is export { } # exponent with circumflex accent
