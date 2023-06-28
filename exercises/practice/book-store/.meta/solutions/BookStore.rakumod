unit module BookStore;

constant @discounts = .95, .9, .8, .75;

sub best-price (%basket) is export {
    my @groups;

    for %basket.values -> $count {
        for ^$count {
            @groups[$_]++;
        }
    }
    
    while @groups ∋ 5 & 3 {
        @groups[@groups.first(* == 5, :k)]--;
        @groups[@groups.first(* == 3, :k)]++;
    }
    
    return @groups.map({ ( $_ > 1 ?? @discounts[$_ - 2] * $_ !! $_ ) * 8 }).sum.Rat;
}
