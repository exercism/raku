unit module KindergartenGarden;

constant %PLANTS = 
    :C<clover>,
    :G<grass>,
    :R<radishes>,
    :V<violets>,
;

sub plants (:$diagram, :$student) is export {
    return %PLANTS{
        $diagram
        .lines
        .map(*.substr((ord($student) - ord('A')) * 2, 2).comb.Slip)
    };
}
