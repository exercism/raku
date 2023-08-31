unit module LanguageList;

sub add-language (@languages, $language) is export {
    return |@languages, $language;
}

sub remove-language (@languages) is export {
    return @languages[0..*-2]
}

sub first-language (@languages) is export {
    return @languages[0];
}

sub last-language (@languages) is export {
    return @languages[*-1] // Nil;
}

sub get-languages (@languages, @elems) is export {
    return @languages[@elems.map(* - 1)];
}

sub has-language (@languages, $language) is export {
    return so @languages.first(* eq $language);
}
