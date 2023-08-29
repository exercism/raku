## Variables

Variables are symbolic names, which refer to either values or containers.
Variable names can start with or without a special character called a [sigil][sigils], followed by an identifier.
A sigil can also be followed by a [twigil][twigils].

Different sigiled variables hold different kinds of data structures.

```raku
my $scalar; # Assigned value will be stored as-is
my @array;  # Assigned value will be coerced into an array
my %hash;   # Assigned value will be coerced into a hash
my &code;   # Assigned value must be a code object
```

Twigils you will commonly see are `^` and `:`, which act as shortcuts for code block signatures.
The `^` is for positional parameters.
The `:` is for named parameters.

```raku
{ $^a + $^b }; #`[same as] ->  $a,  $b { $a + $b }; # Called with (1, 2)
{ $:a + $:b }; #`[same as] -> :$a, :$b { $a + $b }; # Called with (a => 1, b => 2)
```

## Containers

Containers are what allow for a variable to be modified.

Variables declared with `constant`, and sigilless variables (declared with a `\` before the identifier), do not have containers and instead refer directly to values.

```raku
my $foo = 1;
$foo = 2;

constant $bar = 3;
my \baz = 4;

# The following will fail
$bar = 5;
baz  = 6;
```

## Types

Variables can be declared with a type constraint.
Type constraints can also have coercions, by giving an accepted type as an argument to the desired type.

```raku
my Bool   $foo = True; # Booleans only.
my Bool() $bar = 0;    # Accepts type `Any`. Coerced to False.

my Str(Bool(Int)) $baz;
$baz = 1;   # "True"
$baz = "1"; # "1"
```

Using type constraints is a way of making use of multi-dispatch routines.

```raku
multi foo (Int $bar) { say 'Type of arg to $bar is Int!' }
multi foo (Str $bar) { say 'Type of arg to $bar is Str!' }
```

Types in Raku are just another kind of object.
Declaring a `class`, `role`, or `enum` are ways of creating your own type objects.
For example, the built-in type `Bool` is built with an enum: `enum Bool <False True>`.

You can also create simple type constraints based on other types with the `subset` keyword.
You can further restrict this new type by using a `where` clause.
A `where` clause can also be used in a signature.

```raku
subset PositiveInt of Int where * > 0;

sub is-even (PositiveInt $n where  %% 2) { say "$n is even!" }
```

[sigils]: https://docs.raku.org/language/variables#Sigils
[twigils]: https://docs.raku.org/language/variables#Twigils
