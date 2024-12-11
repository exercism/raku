unit module Proverb;

sub recite (*@nouns --> Str()) is export {
  given @nouns.elems {
    when 0  { Empty                                      }
    when 1  { "And all for the want of a {@nouns.head}." }
    default {
      join "\n",
      @nouns
      .rotor(2=>-1)
      .map( { "For want of a {.head} the {.tail} was lost." } ),
      recite @nouns.head
    }
  }
}
