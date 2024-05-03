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
        has @.rolls is List;
        has Bool:D $.is-final = False;
        has UInt:D $!max-roll = 10;

        multi method add-roll ($pins where * < 0) {
            X::Bowling::NegativePins.new.throw;
        }
        
        multi method add-roll ($pins where * > $!max-roll) {
            X::Bowling::TooManyPins.new.throw;
        }

        multi method add-roll ($pins) {
            if $.is-final {
                if @.rolls == 2 {
                    $!max-roll = 0;
                }
                elsif @.rolls == 1 && @.rolls[0] != 10 {
                    $!max-roll = @.rolls[0] + $pins == 10 ?? 10 !! 0;
                }
                elsif @.rolls == 1 && @.rolls[0] == 10 && $pins < 10 {
                    $!max-roll -= $pins;
                }
            }
            elsif !@.rolls {
                $!max-roll -= $pins;
            }
            elsif @.rolls == 1 {
                $!max-roll = 0;
            }

            @!rolls := |@!rolls, $pins;
        }

        method is-strike {
            return Nil if $.is-final || $.is-complete.not;
            return @.rolls == 1 && @.rolls[0] == 10;
        }

        method is-spare {
            return Nil if $.is-final || $.is-complete.not;
            return @.rolls == 2 && @.rolls.sum == 10;
        }

        method is-complete {
            return $!max-roll == 0;
        }
    }

    has Frame @!frames = Frame.new;

    method roll ($pins) {
        X::Bowling::GameOver.new.throw if $.is-complete;

        given @!frames[*-1] -> $current-frame {
            $current-frame.add-roll($pins);

            if $current-frame.is-complete && $current-frame.is-final.not {
                @!frames.push(Frame.new(:is-final(@!frames.elems == 9)));
            }
        }
    }

    method score {
        X::Bowling::GameInProgress.new.throw if $.is-complete.not;

        return sum gather {
            for ^@!frames -> $i {
                given @!frames[$i] {
                    .take for .rolls;

                    when .is-strike {
                        .take for @!frames[$i+1].rolls[* > 2 ?? ^2 !! *];
                        take @!frames[$i+2].rolls[0] if @!frames[$i+1].rolls == 1;
                    }

                    when .is-spare {
                        take @!frames[$i+1].rolls[0];
                    } 
                }
            }
        }
    }

    method is-complete {
        return .is-final && .is-complete given @!frames[*-1];
    }
}
