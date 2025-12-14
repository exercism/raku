unit module Wordy;

grammar Calculate {
    rule TOP     { What is <problem> \? }
    rule problem { <num> [ <operator> <num> ] * }
    token num    { '-'? <[0..9]>+ }
    token operator {
        || plus
        || minus
        || [ multiplied || divided ] ' by'
    }
}

class Calculation {
    method TOP ($/) { make $<problem>.made }

    method num ($/) { make $/.Numeric }

    method operator ($/) {
        given $/ {
            when 'plus'          { make &infix:<+> }
            when 'minus'         { make &infix:<-> }
            when 'multiplied by' { make &infix:<×> }
            when 'divided by'    { make &infix:<÷> }
        }
    }

    method problem ($/) {
        my @nums = $<num>.map(*.made);
        my $result = @nums.shift;

        for $<operator>.map(*.made) -> &op {
            $result = op $result, @nums.shift;
        }

        make $result;
    }
}

sub answer ($question) is export {
    Calculate.parse( $question, :actions(Calculation.new) ).made
      orelse fail 'unable to parse problem';
}
