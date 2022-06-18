unit module Alphametics;

use Exercism::QuickSolve;

sub solve-alphametics ($puzzle) is export {
    quicksolve(
        input => $puzzle,
        input-key => 'puzzle',
    ).Bag;
}
