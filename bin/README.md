# Readme

The `exercise-gen.raku` file can be used in the following ways:
* From within the directory of the exercise you wish to generate a test for.
* With arguments specifying which exercises you want to generate tests for.
  e.g. `./exercise-gen.raku hello-world leap`.
* With the argument `--all` to run the generator for all exercises.
  i.e `./exercise-gen.raku --all`

You must install the dependencies found in `META6.json`, which can be done with the command `zef install --deps-only .`.

You will need to sync the exercise data using Exercism's configlet script.
The generator will retrieve data from `.meta/template-data.yaml` within each exercise directory, and use the contained information to generate test files using `templates/test.mustache`, and `.pm` files using `templates/module.mustache`.
If it finds a `canonical-data.json` file for the exercise in question (via `bin/configlet sync`), the data can be used to generate tests for each `property` found in this data.

Example of a yaml file:
```yaml
# This is a string containing Raku code, to be inserted before any properties
tests: |-
  my $baz;

# Each JSON test case is decoded and stored in variable `%case`.
# The goal is to create a string of Raku code inserted into a template.
properties:
  foo:
    test: |-
      sprintf(q:to/END/, %case<input><data>, %case<expected>, %case<description>.raku);
      cmp-ok(
          foo( %s ),
          "eqv",
          %s,
          %s,
      );
      END

  bar:
    test: |-
      sprintf(q:to/END/, %case<input><data>, %case<expected>, %case<description>.raku);
      cmp-ok(
          bar( %s ),
          "eqv",
          %s,
          %s,
      );
      END

unit: module

# The module we use to check the tests work.
example: |-
    sub foo is export {
        return True;
    }

    sub bar is export {
        return False;
    }

# The module the student receives to work on
stub: |-
    sub foo is export {
        return Nil;
    }

    sub bar is export {
        return Nil;
    }
```
