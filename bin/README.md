The `exercise-gen.p6` file can be used in the following ways:
* From within the directory of the exercise you wish to generate a test for. [showterm example](http://showterm.io/cc7ddb7b23bb73e784d7d)
* With arguments specifying which exercises you want to generate tests for.  
  e.g. `./exercise-gen.p6 hello-world leap`. [showterm example](http://showterm.io/54d5cf196eb45a0e40640)
* With the argument `--all` to run the generator for all exercises.  
  i.e `./exercise-gen.p6 --all`

You will either need to create a symlink to or clone the
[problem-specifications](https://github.com/exercism/problem-specifications) repository
into the root directory of this repository.
The generator will retrieve data from the `.meta/exercise-data.yaml` file within
each exercise directory, and use the contained information to generate
test files using `templates/test.mustache`, and Example.pm6 files using
`templates/module.mustache`. If it finds a `canonical-data.json` file in
`problem-specifications` for the exercise in question it will be included.

Example of a yaml file:
```yaml
exercise: MyExercise
plan: 2
modules:
  - use: Data::Dump
  - use: Foo::Bar
methods: 'foo bar'
tests: |-
  ok my-subroutine, 'Raku code here';
  pass;

unit: module
examples:
  base: |-
    sub my-subroutine is export {
      True;
    }

    class MyClass is export {
    }
```

You must have `Template::Mustache` and `YAMLish` to run `exercise-gen.p6`.
