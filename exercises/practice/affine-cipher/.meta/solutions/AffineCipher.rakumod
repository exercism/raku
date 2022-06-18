unit module AffineCipher;

use Exercism::QuickSolve;

sub encode-affine ($input) is export {
    quicksolve(
        :$input,
        :property<encode>,
    );
}

sub decode-affine ($input) is export {
    quicksolve(
        :$input,
        :property<decode>,
    );
}
