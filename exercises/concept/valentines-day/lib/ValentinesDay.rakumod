unit module ValentinesDay;

subset Answer of Nil is export;

subset Walk of Num is export;

class Chill is export {}

role Restaurant is export {}
class Korean does Restaurant is export {}

role Movie is export {}
class Crime does Movie is export {}

role Game is export {}
class Chess does Game is export {}

subset Activity is export where * ~~ any(Chill);

multi rate-activity ( Chill --> Answer ) is export {
}

multi rate-activity ( Restaurant $cuisine --> Answer ) is export {
}
