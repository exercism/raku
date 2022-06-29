unit module BeerSong;

sub sing (:$bottles, :$verses) is export {
  my $remaining-bottles = $bottles;
  my @verses;
  for 1..$verses {
    if $remaining-bottles {
      my $s = $remaining-bottles > 1 ?? 's' !! '';
      my $one = $remaining-bottles == 1 ?? 'it' !! 'one';
      my $str = (qq:to/VERSE/).trim ~ ' ';
      $remaining-bottles bottle$s of beer on the wall, $remaining-bottles bottle$s of beer.
      Take $one down and pass it around,
      VERSE
      @verses.push( $str ~ (--$remaining-bottles || 'no more') ~ ' bottle' ~ ($remaining-bottles == 1 ?? '' !! 's') ~ ' of beer on the wall.');
    }
    else {
      my $str = (q:to/VERSE/).trim;
      No more bottles of beer on the wall, no more bottles of beer.
      Go to the store and buy some more, 99 bottles of beer on the wall.
      VERSE
      @verses.push($str);
    }
  }
  return @verses.join("\n\n");
}
