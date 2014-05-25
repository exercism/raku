class Word_Counter {
    method count_words ($text) {
        my %word_counts;
        for $text.comb(/\w+/) {
            %word_counts{$_.lc}++;
        }
        %word_counts;
    }
}
