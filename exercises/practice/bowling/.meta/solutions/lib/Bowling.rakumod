my class X::Bowling::GameOver is Exception {
    method message {'Cannot roll after game is over'}
}

my class X::Bowling::GameInProgress is Exception {
    method message {'Score cannot be taken until the end of the game'}
}

my class X::Bowling::TooManyPins is Exception {
    method message {'Pin count exceeds pins on the lane'}
}

my class X::Bowling::NegativePins is Exception {
    method message {'Negative roll is invalid'}
}

class Bowling {
    my class Frame {
        has UInt @.rolls;
        has Bool:D $.is-final = False;

        method is-strike {
            return Nil if $.is-final;
            return @.rolls == 1 && @.rolls[0] == 10;
        }

        method is-spare {
            return Nil if $.is-final;
            return @.rolls == 2 and @.rolls.sum == 10;
        }

        method is-complete {
            if $.is-final {
                return @.rolls.elems == 3 || @.rolls.elems == 2 && @.rolls.sum < 10;
            }
            return @.rolls.elems == 2 || self.is-strike;
        }
    }

    has Frame @!frames = Frame.new;

    multi method roll ($pins where * < 0) {
        X::Bowling::NegativePins.new.throw;
    }

    multi method roll ($pins where * > 10) {
        X::Bowling::TooManyPins.new.throw;
    }

    multi method roll ($pins) {
        X::Bowling::GameOver.new.throw if self.is-complete;

        given @!frames[*-1] -> $current-frame {
            if !$current-frame.is-final && $current-frame.rolls[0].defined && $current-frame.rolls[0] + $pins > 10 {
                X::Bowling::TooManyPins.new.throw;
            }

            $current-frame.rolls.push($pins);
            if $current-frame.is-complete && !$current-frame.is-final {
                @!frames.push(Frame.new(:is-final(@!frames.elems == 9)));
            }
        }
    }

    method score {
        X::Bowling::GameInProgress.new.throw unless self.is-complete;
        return @!frames.map(*.rolls.sum).sum;
    }

    method is-complete {
        return @!frames[*-1].is-final && @!frames[*-1].is-complete;
    }
}
