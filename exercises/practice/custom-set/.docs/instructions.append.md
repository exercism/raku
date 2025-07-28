## Set Operators

`raku` has (built-in set support.)[https://docs.raku.org/language/setbagmix]

Operators are available in mathematical notation (via Unicode) along with ASCII equivalents:

| Unicode | ASCII     | Description
| :-----: | :-------- | :----------
| `∅`     |  `set()`  | empty set
| `∩`     |  `(&)`    | intersection
| `∪`     |  `(\|)`   | union
| `∖`     |  `(-)`    | set difference
| `⊖`     |  `(^)`    | set symmetric difference
|         |           |
| `∈`     | `(elem)`  | is an element of
| `∉`     | `!(elem)` | is not an element of
| `∋`     | `(cont)`  | contains
| `∌`     | `!(cont)` | does not contain
| `⊆`     | `(<=)`    | is a subset or equal to
| `⊈`     | `!(<=)`   | is not a subset or equal to
| `⊂`     | `(<)`     | is a strict subset of
| `⊄`     | `!(<)`    | is not a strict subset of
| `⊇`     | `(>=)`    | is a superset or equal to
| `⊉`     | `!(>=)`   | is not a superset or equal to
| `⊃`     | `(>)`     | is a strict superset of
| `⊅`     | `!(>)`    | is not a strict superset of
| `≡`     | `(==)`    | are identical
| `≢`     | `!(==)`   | not identical

