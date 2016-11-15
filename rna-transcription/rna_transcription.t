use v6;
use Test;
use lib './';

plan 7;

BEGIN { 
    my $module = %*ENV{'EXERCISM'} ?? 'Example' !! 'RNA_Transcription';
    EVAL("use $module");
}; 

pass 'Load module';

ok RNA_Transcription.can('to_rna'), 'Class RNA_Transcription has to_rna() method';

is RNA_Transcription.to_rna('C'), 'G',  'cytidine unchanged';
is RNA_Transcription.to_rna('G'), 'C',  'guanosine unchanged';
is RNA_Transcription.to_rna('T'), 'A',  'adenosine unchanged';
is RNA_Transcription.to_rna('A'), 'U',  'thymidine to uracil';
is RNA_Transcription.to_rna('ACGTGGTCTTAA'), 'UGCACCAGAAUU', 'transcribes all occurences';
