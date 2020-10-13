unit module GradeSchool;

sub roster ( :@students!, :$grade ) is export {
  my %roster;
  for @students {
    %roster{.[1]} = %roster{.[1]}.push(.[0]).sort.Array;
  }
  return $grade
    ?? %roster{$grade} || []
    !! %roster.pairs.sort.map(|*.value);
}
