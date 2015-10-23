use v6;
use Test;
use lib './';

BEGIN {
    plan 7;

    my @files = <Example DNA>;
    my $file = @files.grep({ ( $_ ~ '.pm' ).IO.f })[0] 
        or exit flunk "neither " ~ ( @files.map({ $_ ~ '.pm' }).join( ' or ' ) ) ~ ' found';
    EVAL( 'use ' ~ $file );
    pass 'Load module';
}

ok RNA_Transcription.can('to_rna'), 'Class RNA_Transcription has to_rna() method';

is RNA_Transcription.to_rna('C'), 'G',  'cytidine unchanged';
is RNA_Transcription.to_rna('G'), 'C',  'guanosine unchanged';
is RNA_Transcription.to_rna('T'), 'A',  'adenosine unchanged';
is RNA_Transcription.to_rna('A'), 'U',  'thymidine to uracil';
is RNA_Transcription.to_rna('ACGTGGTCTTAA'), 'UGCACCAGAAUU', 'transcribes all occurences';
