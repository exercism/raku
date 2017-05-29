# xPerl6

[![Build Status](https://travis-ci.org/exercism/xperl6.svg?branch=master)](https://travis-ci.org/exercism/xperl6) [![Gitter](https://badges.gitter.im/exercism/xperl.svg)](https://gitter.im/exercism/xperl?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)

Exercism exercises in Perl 6

## Contributing Guide

Please see the [contributing guide](https://github.com/exercism/x-common/blob/master/CONTRIBUTING.md).

## Code of Conduct

Help us keep Exercism welcoming. Please read and abide by the
[Code of Conduct](https://github.com/exercism/exercism.io/blob/master/CODE_OF_CONDUCT.md).

## Adding and Updating Exercises

Please use `exercise-gen.pl6` in the `bin/` directory when either adding or updating an exercise.
The `bin/` directory contains a `README.md` with information on how to use the generator.

When adding a new exercise, ensure that the exercise is included in the `exercises` array in `config.json`.

## Running The Tests

Set `EXERCISM` as an environment variable (e.g. `export EXERCISM=1` in bash), and run either  `prove -re perl6`
to run all tests in all subdirectories, or `prove -e perl6 /path/to/test.t` to run an individual test file.


### Perl 6 icon
The Perl 6 "Camelia" logo is owned by Larry Wall and is released under version 2.0 of the Artistic License. We are using it to identify the Perl 6 language itself, not any part of Exercism, which we believe to be admissible under fair use. The version of the logo that we are using is a pink, black and white adaptation of the logo found on <http://en.wikipedia.org/wiki/Perl_6>.
