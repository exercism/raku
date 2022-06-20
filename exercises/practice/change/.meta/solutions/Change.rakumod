unit module Change;

use Exercism::QuickSolve;

sub fewest-coins (:@coins, :$target) is export {
    quicksolve(
        input => { :@coins, :$target },
        property => 'findFewestCoins',
    );
}
