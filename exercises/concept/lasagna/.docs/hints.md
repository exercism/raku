# Hints

## 1. Define the expected oven time in minutes

- You need to assign the correct value to the `$EXPECTED-MINUTES-IN-OVEN` constant.

## 2. Calculate the remaining oven time in minutes

- You can subtract numbers from each other using the [infix `-` operator][&infix:<->].

## 3. Calculate the preparation time in minutes

- You can multiply numbers using the [infix `*` or `×` operators][&infix:<*>].

## 4. Calculate the total working time in minutes

- You can call other defined functions you might find useful, e.g., `function($arg)`.
- You can add numbers to each other using the [infix `+` operator][&infix:<+>].

## 5. Create a notification that the lasagna is ready

- You can create a string by enclosing text in either single `'foo'` or double `"bar"` quotes.
  See [Quoting Constructs][quoting].

[&infix:<+>]: https://docs.raku.org/language/operators#infix_+
[&infix:<*>]: https://docs.raku.org/language/operators#infix_*
[&infix:<->]: https://docs.raku.org/language/operators#infix_-
[quoting]: https://docs.raku.org/language/quoting
