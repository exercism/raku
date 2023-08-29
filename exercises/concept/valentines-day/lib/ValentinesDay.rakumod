unit module ValentinesDay;

enum Answer is export (Yes => True,);

# You may use enums, subsets, classes, or roles as you see fit.
class  Chill       is export {}
enum   Restaurant  is export ('Korean',);
enum   Movie       is export ();
enum   Game        is export ();
subset Walk of Num is export;

subset Activity is export where * ~~ any(Chill);

multi rate-activity ( Chill --> Answer ) is export {
}

multi rate-activity ( Restaurant $cuisine --> Answer ) is export {
}
