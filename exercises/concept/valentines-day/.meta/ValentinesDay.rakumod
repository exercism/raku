unit module ValentinesDay;

enum Answer is export (:!No, :Yes);

class  Chill       is export {}
enum   Restaurant  is export <Korean Turkish>;
enum   Movie       is export <Crime Horror Romance>;
enum   Game        is export <Chess TicTacToe GlobalThermonuclearWar>;
subset Walk of Num is export where * ~~ 0^..^Inf;

subset Activity is export where * ~~ any(Restaurant, Movie, Walk, Game, Chill);

multi rate-activity ( Chill --> No )  is export {}

multi rate-activity ( Restaurant $cuisine --> Answer(Bool) ) is export {
    return $cuisine ~~ Korean || Answer;
}

multi rate-activity ( Movie $genre --> Answer(Bool) ) is export {
    return $genre ~~ Romance;
}

multi rate-activity ( Walk $kilometers --> Answer(Bool) ) is export {
    return $kilometers ~~ 3..^5 ?? Answer !! $kilometers ~~ ^3;
}

multi rate-activity ( Game $game --> Answer(Bool) ) is export {
    return No  if $game ~~ GlobalThermonuclearWar;
    return Yes if $game ~~ Chess;
    return Answer;
}
