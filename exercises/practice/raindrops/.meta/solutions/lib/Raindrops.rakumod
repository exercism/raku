unit module Raindrops;

sub raindrop ( Int:D $_ --> Str(Cool) ) is export {
  [~] gather {
    take 'Pling' when * %% 3;
    take 'Plang' when * %% 5;
    take 'Plong' when * %% 7;
  } || $_;
}
