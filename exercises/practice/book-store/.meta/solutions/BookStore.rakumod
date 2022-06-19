unit module BookStore;

use Exercism::QuickSolve;

sub best-price (@basket) is export {
    Rat.new(quicksolve(
        input => @basket,
        input-key => 'basket',
        property => 'total',
    ), 100);
}
