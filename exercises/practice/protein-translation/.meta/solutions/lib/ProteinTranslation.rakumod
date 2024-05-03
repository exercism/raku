unit module ProteinTranslation;

my class X::InvalidCodon is Exception {
    method message {
        'Invalid codon'
    }
}

our %PROTEIN is default(X::InvalidCodon) = {
    Methionine => <AUG>,
    Phenylalanine => <UUU UUC>,
    Leucine => <UUA UUG>,
    Serine => <UCU UCC UCA UCG>,
    Tyrosine => <UAU UAC>,
    Cysteine => <UGU UGC>,
    Tryptophan => <UGG>,
    STOP => <UAA UAG UGA> }.invert;

sub protein-translation (Str $rna --> Seq) is export {
    $rna.comb(3).map: { given %PROTEIN{$_} {
        when 'STOP' { last }
        when X::InvalidCodon { $_.new.throw }
        default { $_ or [] }
    }}
}
