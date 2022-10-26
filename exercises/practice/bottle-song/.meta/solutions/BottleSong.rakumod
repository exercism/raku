unit module BottleSong;

my %numbers = 1..10 Z=> <one two three four five six seven eight nine ten>;
sub sing (:$bottles, :$verses --> Str) is export {
  my $remaining-bottles = $bottles;
  my @verses;
  for 1..$verses {
      my $s = $remaining-bottles > 1 ?? 's' !! '';
      @verses.push(
          "%numbers{$remaining-bottles} green bottle$s hanging on the wall,\n".tc x 2
          ~ "And if one green bottle should accidentally fall,\n"
          ~ "There'll be {%numbers{--$remaining-bottles} || 'no'} green bottle{$remaining-bottles == 1 ?? '' !! 's'} hanging on the wall."
      );
  }
  return @verses.join("\n\n");
}
