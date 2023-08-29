## Booleans

Raku has `True` and `False` boolean literals.
In boolean context, anything undefined will be considered `False`.
In addition to `Bool::False` itself, defined values which are considered `False` include `0`, `NaN`, `()` (empty list), `""` (empty string), and objects of type `Failure`.

The [prefix `?`][&prefix:<?>] operator will force boolean context on an object.
Its behaviour is the same as calling the [`Bool`][routine/Bool] method on that object.
The [prefix `!`][&prefix:<!>] operator will give the inverse of prefix `?`.

## Boolean Infix Operators

### Smartmatch

The [infix `~~`][&infix:<~~>] AKA smartmatch operator is a commonly used tool in Raku.
Its behaviour is dependent on what object is given on the right side of the operator, as it is a shortcut for the [`ACCEPTS`][routine/ACCEPTS] method of that object.
The value on the left side is given as an argument to `ACCEPTS`.
The result is a boolean value.

### Logical AND/OR

Raku has [`&&`][&infix:<&&>]/[`and`][&infix:<and>], [`||`][&infix:<||>]/[`or`][&infix:<or>], [`//`][&infix:<//>]/[`orelse`][&infix:<orelse>], and [`^^`][&infix:<^^>]/[`xor`][&infix:<xor>] operators for boolean logic (tight and loose precedence respectively).
These can be chained.

```raku
1 xor 1 xor 1;
# Nil in Raku, 1 in Perl (because the latter makes the first pair false).
```

### Ternary

Raku has a ternary/conditional [infix `?? !!`][infix-??-!!] operator, which is written as `$condition ?? $true !! $false`.

## Control Flow

### if/elsif/else

An [`if`][control-if] statement is used to conditionally run a block of code.
To create an `if` statement, the `if` keyword is followed by an [expression][statements-and-expressions], then followed by a [block][control-block].

The expression is evaluated in [boolean context][contexts-boolean], and the block will be executed if the expression evaluates to `True`.

An `if` statement can be extended with the keywords [`elsif` and `else`][control-else/elsif], written in the same way as `if`. An `else` block will execute if all previous expressions evaluate to `False`, and an `elsif` block will execute in the same way, if its own expression evaluates to `True`.

Alternatively, `if` can be used in the statement modifier form:

```raku
say 'success' if True;
```

The statement modifier form cannot be used with `elsif` or `else`.

### given/when/default

The [`given`][control-given] statement is Raku's topicalizing keyword in a similar way that `switch` topicalizes in languages such as C.
The keywords for individual cases are [`when` and `default`][control-default-and-when].

### for/while/loop

A [`for`][control-for] statement iterates over a given list, and runs a block for each item present in that list.

A [`while`][control-while] statement repeatedly runs a block while its given expression evaluates to `True`.

A [`loop`][control-loop] statement can be written in two ways.
If it is only given a block, it will run that block repeatedly until something explicitly breaks the loop.
It can also be written as a C-style `for` loop, with an initializer, a conditional, and an incrementer in parentheses before the block.

```raku
loop (my $i = 0; $i < 10; $i++) {
    say $i;
}
```

[routine/Bool]: https://docs.raku.org/routine/Bool
[routine/ACCEPTS]: https://docs.raku.org/routine/ACCEPTS
[&prefix:<?>]: https://docs.raku.org/language/operators#prefix_?
[&prefix:<!>]: https://docs.raku.org/language/operators#prefix_!
[&infix:<~~>]: https://docs.raku.org/language/operators#infix_~~
[control-if]: https://docs.raku.org/language/control#if
[control-block]: https://docs.raku.org/language/control#Blocks
[statements-and-expressions]: https://docs.raku.org/language/syntax#Statements_and_expressions
[contexts-boolean]: https://docs.raku.org/language/contexts#Boolean
[control-else/elsif]: https://docs.raku.org/language/control#else/elsif
[&infix:<&&>]: https://docs.raku.org/language/operators#infix_&&
[&infix:<and>]: https://docs.raku.org/language/operators#infix_and
[&infix:<||>]: https://docs.raku.org/language/operators#infix_||
[&infix:<or>]: https://docs.raku.org/language/operators#infix_or
[&infix:<//>]: https://docs.raku.org/language/operators#infix_//
[&infix:<orelse>]: https://docs.raku.org/language/operators#infix_orelse
[&infix:<^^>]: https://docs.raku.org/language/operators#infix_^^
[&infix:<xor>]: https://docs.raku.org/language/operators#infix_xor
[infix-??-!!]: https://docs.raku.org/language/operators#infix_??_!!
[control-given]: https://docs.raku.org/language/control#given
[control-default-and-when]: https://docs.raku.org/language/control#default_and_when
[control-for]: https://docs.raku.org/language/control#for
[control-while]: https://docs.raku.org/language/control#while,_until
[control-loop]: https://docs.raku.org/language/control#loop
