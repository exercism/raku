## Variables

We'll only use scalar [variables][variables] in basics to keep things simple.

Scalar variables are [identifiers][identifiers] prefixed with the `$` sigil.

Scalar variables can contain virtually anything, and have a default type of [Any][Any].

Most variables you use will need a [declaration][variable-declarator].
For now, stick with [my][my] and [constant][constant].

```raku
my $foo;
constant $BAR;
```

## Subroutines

A subroutine is declared with the [sub][sub-declarator] declarator.

A `sub` declaration is followed by an optional [identifier][identifiers], followed by an optional [signature][signatures], followed by a [block][blocks].

Subrouties (among other things) can be exported by adding the [is export][exporting] trait.

A subroutine can be called with a [postcircumfix ( )][postcircumfix-()] operator on the identifier.

```raku
sub foo ($bar) is export { ... } # Subroutine definition

foo($bar); # Subroutine call
```

## Operators

Raku has a wide variety of [operators][operators].
We will be using some basic mathematical operators in Raku, such as `+` and `-`, for the exercises in the basics concept.

```raku
say 0.1 + 0.2 - 0.3;
# Raku is not like other languages -> https://0.30000000000000004.com/#raku
```

You can easily define your own operators in Raku if you wish.
Most built-in operators are also available as subroutines.

## Packages and Modules

There are several types of [packages][package-declarator] in Raku. We will only use `module` in basics.

To declare an entire file as a `module`, the module declaration is prefixed with `unit`.

```raku
unit module Foo;

sub bar () { ... }
```

## Comments

Raku has [single-line][single-line-comments] and [multi-line/embedded][multi-line-comments] comments.

Single-line comments start with `#` and continue until the end of the line.

Multi-line/embedded comments start with a hash followed by a backtick and a Unicode Open Punctuation character.
They end with a paired matching close character.

```raku
# This is a single-line comment

#`(
    This is a
    multi-line/embedded comment
)
```

## Style Conventions

Variable and subroutine [identifiers][identifiers] in Raku are styled in `kebab-case`.
Constants are styled in `ALL-CAPS`.
Package names are styled in `PascalCase`.

[Any]: https://docs.raku.org/type/Any
[sub-declarator]: https://docs.raku.org/language/syntax#Subroutine_declaration
[variable-declarator]: https://docs.raku.org/language/variables#Variable_declarators_and_scope
[my]: https://docs.raku.org/language/variables#The_my_declarator
[constant]: https://docs.raku.org/language/variables#The_constant_prefix
[identifiers]: https://docs.raku.org/language/syntax#Identifiers
[signatures]: https://docs.raku.org/language/signatures
[exporting]: https://docs.raku.org/language/modules#Exporting_and_selective_importing
[blocks]: https://docs.raku.org/language/control#Blocks
[package-declarator]: https://docs.raku.org/language/syntax#Package,_Module,_Class,_Role,_and_Grammar_declaration
[postcircumfix-()]: https://docs.raku.org/language/operators#postcircumfix_(_)
[variables]: https://docs.raku.org/language/variables
[single-line-comments]: https://docs.raku.org/language/syntax#Single-line_comments
[multi-line-comments]: https://docs.raku.org/language/syntax#Multi-line_/_embedded_comments
[operators]: https://docs.raku.org/language/operators
