unit module ZebraPuzzle;

my role Owned {
    method owner (::?CLASS:D:) {
        return Nil;
    }
}

my role Drinkable {
    method drinker (::?CLASS:D:) {
        return Nil;
    }
}

enum Beverage does Drinkable is export <Coffee Milk OrangeJuice Tea Water>;
enum Nationality             is export <Englishman Japanese Norwegian Spaniard Ukranian>;
enum Pet does Owned          is export <Dog Fox Horse Snails Zebra>;
enum SmokeBrand                        <Chesterfield Kools LuckyStrike OldGold Parliament>;

