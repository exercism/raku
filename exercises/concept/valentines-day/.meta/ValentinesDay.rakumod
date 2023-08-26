unit module ValentinesDay;

subset Answer of Bool is export;
subset Walk   of Num  is export where * ~~ 0^..^Inf;

class Chill is export {}

role Restaurant is export {}
class Korean  does Restaurant is export {}
class Turkish does Restaurant is export {}

role Movie is export {}
class Crime    does Movie is export {}
class Horror   does Movie is export {}
class Romance  does Movie is export {}

role Game is export {}
class Chess     does Game is export {}
class TicTacToe does Game is export {}
class GlobalThermonuclearWar does Game is export {}

subset Activity is export where * ~~ any(Restaurant, Movie, Walk, Game, Chill);

multi rate-activity ( Chill --> Answer ) is export {
    return False;
}

multi rate-activity ( Restaurant $cuisine --> Answer ) is export {
    return $cuisine ~~ Korean || Answer;
}

multi rate-activity ( Movie $genre --> Answer ) is export {
    return $genre ~~ Romance;
}

multi rate-activity ( Walk $kilometers --> Answer ) is export {
    return $kilometers ~~ 3..^5 ?? Answer !! $kilometers ~~ ^3;
}

multi rate-activity ( Game $game --> Answer ) is export {
    return False if $game ~~ GlobalThermonuclearWar;
    return True  if $game ~~ Chess;
    return Bool;
}
