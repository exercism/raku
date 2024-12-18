unit module Proverb;

multi recite ( $noun where $_ eq '' ) is export { }
multi recite ( $noun where $_ ne '' ) {
  "And all for the want of a $noun."
}
multi recite ( @nouns ) {
  join "\n",
  @nouns
  .rotor(2=>-1)
  .map( { "For want of a {.head} the {.tail} was lost." } ),
  recite @nouns.head
}
