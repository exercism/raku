# Exercism Raku Track

[![Build Status](https://travis-ci.org/exercism/raku.svg?branch=master)](https://travis-ci.org/exercism/raku) [![Build status](https://ci.appveyor.com/api/projects/status/rcmwcooqd3hw9461?svg=true)](https://ci.appveyor.com/project/mienaikage/perl6) [![Gitter](https://badges.gitter.im/exercism/perl.svg)](https://gitter.im/exercism/perl?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)

Exercism exercises in Raku

## Contributing Guide

Please see the [contributing guide](https://github.com/exercism/docs/blob/master/contributing-to-language-tracks/README.md).

## Code of Conduct

Help us keep Exercism welcoming. Please read and abide by the
[Code of Conduct](https://exercism.io/code-of-conduct).

## Adding and Updating Exercises

Please use `exercise-gen.raku` in the `bin/` directory when either adding or updating an exercise.
The `bin/` directory contains a `README.md` with information on how to use the generator.

When adding a new exercise, ensure that the exercise is included in the `exercises` array in `config.json`.

## Running The Tests

Run `prove -re raku exercises/*/.meta/solutions/` to run all exercise tests.

### Raku icon
The Raku "Camelia" logo is owned by Larry Wall and is released under version 2.0 of the Artistic License. We are using it to identify the Raku language itself, not any part of Exercism, which we believe to be admissible under fair use. The version of the logo that we are using is an adaptation of the logo found on <https://en.wikipedia.org/wiki/Raku_(programming_language)>.
