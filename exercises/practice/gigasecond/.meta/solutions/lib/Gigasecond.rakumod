unit module Gigasecond;

sub giga-later ( $date --> DateTime() ) is export {
   $date.later:     < seconds minutes hours days >
   Z=> 10⁹.polymod: <      60      60    24      >
}
