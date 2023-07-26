unit module Strain;

sub keep ( :@list, :&function ) is export {
    @list.grep(&function);
}

sub discard ( :@list, :&function ) is export {
    @list.grep(&not ∘ &function);
}
