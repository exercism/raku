unit module ComplexNumbers;

sub prefix:<Re> (Numeric $operand) is export { } # real part
sub prefix:<Im> (Numeric $operand) is export { } # imaginary part
sub infix:<＋> (Numeric $operand) is export { } # addition with fullwidth plus sign
sub infix:<－> (Numeric $operand) is export { } # subtraction with fullwidth hyphen-minus
sub infix:<⋅> (Numeric $operand) is export { } # multiplication with dot operator
sub infix:<∕> (Numeric $operand) is export { } # division with division slash
sub circumfix:<｜ ｜> (Numeric $operand) is export { } # absolute value with vertical line
sub postfix:<∗> (Numeric $operand) is export { } # conjugate with asterisk operator
sub infix:<^> (e, Numeric $operand) is export { } # exponent with circumflex accent
