sub sum-of-multiples (:@factors, :$limit) is export {
    sum grep * %% @factors.grep( 1 .. * ).any, 1 ..^ $limit
}
