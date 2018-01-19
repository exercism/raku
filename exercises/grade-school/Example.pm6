unit module GradeSchool:ver<3>;

class Roster is export {
  has %!roster;

  method add-student (Str:D :$name!, Int:D :$grade!) {
    %!roster.append($grade, $name);
  }

  method list-grade (Int:D $grade --> Seq:D) {
    %!roster{$grade}.sort;
  }

  method list-all {
    my @list.append("Grade $_", %!roster{$_}.sort) for %!roster.keys.sort;
    return @list;
  }
}
