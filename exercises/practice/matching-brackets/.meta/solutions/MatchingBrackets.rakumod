unit module MatchingBrackets;

grammar Balanced {
    token TOP         { <balanced> * }
    token balanced    { <parentheses> | <brackets> | <braces> | <other> }
    token parentheses { '(' ~ ')' <balanced> * }
    token brackets    { '[' ~ ']' <balanced> * }
    token braces      { '{' ~ '}' <balanced> * }
    token other       { <-[()\[\]{}]>        + }
}
sub has-matching-brackets ($string) is export {
  Balanced.parse($string).so
}
