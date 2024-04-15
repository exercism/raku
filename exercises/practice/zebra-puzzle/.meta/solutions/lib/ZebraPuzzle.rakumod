unit module ZebraPuzzle;

my role Owned {
    method owner (::?CLASS:D:) {
        return ::('Japanese');
    }
}

my role Drinkable {
    method drinker (::?CLASS:D:) {
        return ::('Norwegian');
    }
}

enum Nationality                is export <Englishman Japanese Norwegian Spaniard Ukranian>;
enum Beverage    does Drinkable is export <Coffee Milk OrangeJuice Tea Water>;
enum Pet         does Owned     is export <Dog Fox Horse Snails Zebra>;
enum SmokeBrand                           <Chesterfield Kools LuckyStrike OldGold Parliament>;

