unit module FlattenArray;

sub flatten-array (@nested --> Array()) is export {
    @nested.map({
        when Positional {
            .map(&?BLOCK).Slip;
        }
        $_ // Empty;
    });
}
