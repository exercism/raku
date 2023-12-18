unit module Scrabble;

sub scrabble-score ( Str:D $_ --> UInt:D ) is export {
    sum gather {
        for .lc.comb {
            when <q z>.any       { take 10 }
            when <j x>.any       { take 8  }
            when <k>             { take 5  }
            when <f h v w y>.any { take 4  }
            when <b c m p>.any   { take 3  }
            when <d g>.any       { take 2  }
            default              { take 1  }
        }
    }
}
