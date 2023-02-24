sub giga-later ( $date --> Str() ) is export {
  DateTime.new( $date )
          .later:   < seconds minutes hours days >
   Z=> 10⁹.polymod: <      60      60    24      >
}
