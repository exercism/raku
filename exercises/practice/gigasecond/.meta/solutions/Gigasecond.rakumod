sub giga-later ( $date --> Str() ) is export {
  DateTime.new( $date, formatter => {
    sprintf "%04d-%02d-%02dT%02d:%02d:%02d", .year, .month, .day, .hour, .minute, .second }
  )
          .later:   < seconds minutes hours days >
   Z=> 10⁹.polymod: <      60      60    24      >
}
