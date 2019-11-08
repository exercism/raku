unit module AllYourBase;

enum Error «
  'input base must be >= 2'
  'output base must be >= 2'
  'all digits must satisfy 0 <= d < input base'
»;

sub convert-base ( :%bases!, :@digits! ) is export {
}
