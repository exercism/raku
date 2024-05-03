unit class GradeSchool;

has %!grades;

method add ( Str :$student, Int :$grade --> Bool ) {
    if %(%!grades.invert){$student}:exists {
        return False;
    }
    %!grades{$grade}.push($student);
    return True;
}

method roster ( Int :$grade --> List() ) {
  with $grade {
      with %!grades{$_} {
          return .sort;
      }
      return ();
  }
  return %!grades.pairs.sort({$^a.key <=> $^b.key}).map(*.value.sort.Slip);
}
