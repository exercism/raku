unit module Scrabble;

sub score (Str:D $word --> Int:D) is export {
  my $score = 0;
  for $word.lc.split('',:skip-empty) -> $letter {
    given $letter {
      when * ~~ /<[aeioulnrst]>/ { $score += 1  }
      when * ~~ /<[dg]>/         { $score += 2  }
      when * ~~ /<[bcmp]>/       { $score += 3  }
      when * ~~ /<[fhvwy]>/      { $score += 4  }
      when * ~~ /k/              { $score += 5  }
      when * ~~ /<[jx]>/         { $score += 8  }
      when * ~~ /<[qz]>/         { $score += 10 }
    }
  }
  return $score;
}
