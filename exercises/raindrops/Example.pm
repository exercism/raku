unit module Raindrops:ver<1>;

sub convert (Int:D $num --> Str:D) is export {
  my $str = '';
  given $num {
    when * %% 3 {$str ~= 'Pling'; proceed}
    when * %% 5 {$str ~= 'Plang'; proceed}
    when * %% 7 {$str ~= 'Plong'}
  }
  return $str ?? $str !! $num.Str;
}
