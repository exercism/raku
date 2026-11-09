A `List` is an ordered sequence of values.
A `List` is immutable, but if any of the values in a `List` are containers, the values of those containers can be changed.

An `Array` is a type of List which is mutable, i.e., the contents and size of an array can both be changed.

An `Array` can have a type constraint.

`Array`s and `List`s have the `Positional` role, which allows for using the postcircumfix `[]` operator to access elements by their indexes.
This is also known as [positional subscripting][positional-subscripting].

Indexes start at 0.
Raku does not support negative indexes, but instead a code block can be used inside a positional subscript to emulate the same behavior.
The argument to this code block will be the number of elements in the `List`.

```raku
# All of the following will give 'c'
('a', 'b', 'c')[*-1];
('a', 'b', 'c')[{ $_ - 1 }];
('a', 'b', 'c')[-> $elems { $elems - 1 }];
```

[positional-subscripting]: https://docs.raku.org/language/subscripts#Positional_subscripting
