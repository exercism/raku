class RNA_Transcription is export {
    method to_rna ($dna) {
        $dna.trans( 'A' => 'U',
                    'G' => 'C',
                    'C' => 'G',
                    'T' => 'A');
    }
}
