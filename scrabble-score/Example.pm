class Scrabble {
    has %.values = (
            aeioulnrst => 1,
            dg         => 2,
            bcmp       => 3,
            fhvwy      => 4,
            k          => 5,
            jx         => 8,
            qz         => 10,
            ZERO       => 0,
        );

    method score ($word) {
        my $score = 0;

        for $word.lc.split('') -> $letter {
            $score
            += self.values{ self.values.keys.first(/$letter/) or 'ZERO' };
        }
        return $score;
    }
}
