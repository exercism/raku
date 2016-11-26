#!/usr/bin/env perl6
use v6;
use Test;
use lib IO::Path.new($?FILE).parent.path;

BEGIN {
  plan 7;
  eval-lives-ok %*ENV<EXERCISM>.so ?? 'use Example' !! 'use RNA_Transcription', 'Module loaded';
}

ok RNA_Transcription.can('to_rna'), 'Class RNA_Transcription has to_rna() method';

is RNA_Transcription.to_rna('C'), 'G',  'RNA complement of cytosine is guanine';
is RNA_Transcription.to_rna('G'), 'C',  'RNA complement of guanine is cytosine';
is RNA_Transcription.to_rna('T'), 'A',  'RNA complement of thymine is adenine';
is RNA_Transcription.to_rna('A'), 'U',  'RNA complement of adenine is uracil';
is RNA_Transcription.to_rna('ACGTGGTCTTAA'), 'UGCACCAGAAUU', 'transcribes all occurences';
