unit module BinarySearch;

use Exercism::QuickSolve;

sub binary-search (:@array, :$value) is export {
    quicksolve(
        input => {:@array, :$value},
        property => 'find',
    );
}
