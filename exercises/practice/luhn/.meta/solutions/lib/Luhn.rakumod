unit module Luhn;

sub is-luhn-valid ($input) is export {
    my @digits = $input.comb(/\S/).map({try {.Int} orelse return False});
    return False if @digits.elems < 2;
    @digits.unshift(0) unless @digits %% 2;

    return (gather {
        for @digits {
            take $^a * 2;
            take -9 if $a * 2 > 9;
            take $^b;
        }
    }).sum %% 10;
}
