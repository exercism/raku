class RNA_Transcription {
    method to_rna ($dna) {
        $dna.trans( 'A' => 'U',
                    'G' => 'C',
                    'C' => 'G',
                    'T' => 'A');
    }
}
