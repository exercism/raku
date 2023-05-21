grammar Balanced {
    token TOP         { <balanced> * }
    token balanced    { <parentheses> | <brackets> | <braces> | <other> }
    token parentheses { '(' ~ ')' <balanced> * }
    token brackets    { '[' ~ ']' <balanced> * }
    token braces      { '{' ~ '}' <balanced> * }
    token other       { <-[()\[\]{}]>        + }
}
sub is-paired ($a) is export {
  Balanced.parse($a).so
}
