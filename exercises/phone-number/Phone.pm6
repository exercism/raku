unit module Phone;

constant @errors = (
   '11 digits must start with 1',
   'more than 11 digits',
   'incorrect number of digits',
   'letters not permitted',
   'punctuations not permitted',
   'area code cannot start with zero',
   'area code cannot start with one',
   'exchange code cannot start with zero',
   'exchange code cannot start with one',
);

sub clean-number ($number) is export {
}
