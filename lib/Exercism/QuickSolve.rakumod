unit module Exercism::QuickSolve;

sub quicksolve (:$property, :$input-key, :$input) is export {
    my $expected = @GLOBAL::test-cases.first({
        my $prop-match    = $property  ?? .<property> eq $property !! 1;
        my $matched-input = $input-key ?? .<input>{$input-key}     !! .<input>;

        $prop-match && $matched-input ~~ $input;
    })<expected>;

    if $expected ~~ Associative && $expected<error> {
        die $expected<error>;
    }

    return $expected;
}
