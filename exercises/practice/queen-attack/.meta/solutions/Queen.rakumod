unit class Queen;

has Int() ($.row where 0..7, $.column where 0..7);

method can-attack (:$row, :$column --> Bool() ) {
    with cache map { .head, .tail }, ($.row, $.column), ($row, $column) {
           when    [eqv]                 .list { fail  } # Same square
           when    [==] map *.head,      .list           # Same file
                or [==] map *.tail,      .list           # Same rank
                or [==] map *.abs , [Z-] .list { True  } # Same diagonal
        default                                { False }
    }
}
