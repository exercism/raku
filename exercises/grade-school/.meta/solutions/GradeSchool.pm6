unit module GradeSchool:ver<4>;

sub roster (List:D :$students!, UInt :$grade --> List) is export {
  my %roster;
  $students.map({%roster{.[1]}.push: .[0] andthen .=sort});
  return %roster{$grade} || List if $grade;
  .{.keys.sort}.map(*<>).flat.List given %roster;
}
