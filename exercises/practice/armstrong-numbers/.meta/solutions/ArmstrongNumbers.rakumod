unit module ArmstrongNumbers;

use Exercism::QuickSolve;

sub is-armstrong ($number) is export {
    quicksolve(
      input => $number,
      :input-key<number>,
    );
}
