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
    method roll ($pins) {
    }

    method score {
    }
}
