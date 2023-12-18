unit module SecretHandshake;

sub handshake ( $number ) is export {
    $number +& 16 ?? .reverse !! $_ given gather take .key if $number +& .value
    for ( 'wink', 'double blink', 'close your eyes', 'jump' ) Z=> <1 2 4 8>
}
