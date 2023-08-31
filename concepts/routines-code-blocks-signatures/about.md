Code blocks are used liberally in Raku.
Fundamental for functions, but also in tools such as `grep` and `map`, as blocks of `if`, `for`, `while`, and `given` statements, and even array subscripts.

## Routines

[`Subs`][type/Sub] and [`Methods`][type/Method] are types of [`Routines`][type/Routine] in Raku.

A routine can exited at any time with a return value using the [`return`][control-return] keyword, a useful tool for creating functions.
If no `return` is specified, the last statement of the routine will be its implicit return value.

A routine can have a [`Signature`][language/signatures] inside parentheses before the code block.

[`Routine`][type/Routine] is a subclass of [`Block`][type/Block].

```raku
sub add ($x, $y --> Int) { return $x + $y }
say add(1, 2); # 3
```

Methods will be covered in a separate concept relating to classes and objects.

## Blocks

A [`Block`][type/Block] is a reuseable code object, typically used to create lambdas.

The last statement of a block is its implicit return value.

A block can have a [`Signature`][language/signatures] prefixed with `->` before the code block.

[`Block`][type/Block] is a subclass of [`Code`][type/Code], which is the ultimate base class of all code objects in Raku.

```raku
my $add = -> $x, $y { $x + $y };
say $add(1, 2); # 3
```

## Signatures

A [`Signature`][language/signatures] is made up of zero or more [`Parameters`][type/Parameter], separated by commas.

At the end of a signature, a return type can be specified with a [return type arrow][signatures-return-type-arrow] `-->`.

A signature can be used to specify the arguments a `Block` will accept.

This concept will keep signatures simple, using only positional parameters with scalar-sigiled variables, and a return type.
These will be expanded upon in other concepts.

## Multi-Dispatch

Raku allows for writing several routines with the same name but different signatures by using the `multi` keyword.
This feature is known as [multi-dispatch][multi-dispatch].
When the routine is called by name, the runtime environment determines the proper candidate and invokes it.

This will be covered in more detail in a concept on types.

```raku
multi foo () { say 'No arguments given'}

multi foo ($bar) { say "One argument given: $bar" }
```

## WhateverCode

When a [`Whatever`][type/Whatever] star `*` is used in combination with most operators, a [`WhateverCode`][type/WhateverCode] object is created.
This allows you to create blocks with a simpler syntax.

```raku
# These will all give code blocks that increment a single argument by 1:
-> $x { $x  + 1 }; # Explicit signature
      { $^x + 1 }; # Signature via placeholder variable
      { $_  + 1 }; # Topic variable
          * + 1;   # WhateverCode
```

[type/Sub]: https://docs.raku.org/type/Sub
[type/Method]: https://docs.raku.org/type/Method
[type/Routine]: https://docs.raku.org/type/Routine
[control-return]: https://docs.raku.org/language/control#return
[type/Block]: https://docs.raku.org/type/Block
[language/signatures]: https://docs.raku.org/language/signatures
[type/Parameter]: https://docs.raku.org/type/Parameter
[type/Code]: https://docs.raku.org/type/Code
[signatures-return-type-arrow]: https://docs.raku.org/language/signatures#Return_type_arrow:_--%3E
[multi-dispatch]: https://docs.raku.org/language/functions#Multi-dispatch
[type/Whatever]: https://docs.raku.org/type/Whatever
[type/WhateverCode]: https://docs.raku.org/type/WhateverCode
