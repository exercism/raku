## Run All Tests

There is a Perl 6 script with the extension `.t6`, which will be used to test
your solution. You can run through the tests by using the command:

`prove6 .`

Before you start the exercise, the output will likely look something like:

```

# Failed test 'Say Hi!'
# at hello-world.t6 line 11
# expected: 'Hello, World!'
#      got: (Nil)
# Looks like you failed 1 test of 1
hello-world.t6 .. Dubious, test returned 1
Failed 1/1 subtests
```
You will either need to modify or create a module with the extension `.pm6`, and
write a solution to pass the tests. Once the tests are passing, the output from
the command above will likely look something like:

```
hello-world.t6 .. ok
All tests successful.
```

## Stop After First Failure

If you have the `PERL6_TEST_DIE_ON_FAIL` environment variable set, the test
runner will stop after the first failure. For example:

In Linux / OS X:

```bash
export PERL6_TEST_DIE_ON_FAIL=1
# now all the follow up runs will stop at the first failure
prove6 .
# until we do
unset PERL6_TEST_DIE_ON_FAIL
# or you can use it for one run like this:
PERL6_TEST_DIE_ON_FAIL=1 prove6 .
```

Or in Windows:

```
SET PERL6_TEST_DIE_ON_FAIL=1
REM now all the follow up runs will stop at the first failure
prove6 .
REM until we do
set PERL6_TEST_DIE_ON_FAIL=
```

For more information see the
[Testing chapter of the Perl 6 Documentation](https://docs.perl6.org/language/testing.html).

## Troubleshooting

```
===SORRY!===
Could not find JSON::Fast
```

All modules used in the Perl 6 track are included with Rakudo Star. If you get an
error message such as the above when attempting to run a test, then you will either
need to make sure you have the latest distribution of Rakudo Star, or install the
module yourself using a package manager. See the
[Perl 6 documentation on modules](https://docs.perl6.org/language/modules#Looking_for_and_installing_modules.)
for information on how to install modules.
