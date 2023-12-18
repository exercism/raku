unit module BookStore;

constant @discounts = 1, .95, .9, .8, .75;

sub best-price (%basket) is export {
    my @groups;

    for %basket.values -> $count {
        for ^$count {
            @groups[$_]++;
        }
    }
    
    while @groups ∋ 5 & 3 {
        @groups[@groups.first(5, :k)]--;
        @groups[@groups.first(3, :k)]++;
    }
    
    return @groups.map({ $^books * 8 * @discounts[$books - 1] }).sum.Rat;
}
