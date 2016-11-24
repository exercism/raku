# Running the Tests

## Run All Tests

The test (`.t`) files are just Perl 6 scripts, so you can run them directly as any other script:

`perl6 bob.t`

This will produce an output like:

````
1..2
ok 1 - Load module
ok 2 - Class Bob has hey() method
````

(this is called the [TAP - Test Anything Protocol](https://en.wikipedia.org/wiki/Test_Anything_Protocol) format)

## Stop After First Failure

If you have the `PERL6_TEST_DIE_ON_FAIL` environment variable set, the test runner will stop after the first failure. For example:

In Linux / OS X:

````bash
export PERL6_TEST_DIE_ON_FAIL=1
# now all the follow up runs will stop at the first failure
perl6 bob.t
# until we do
unset PERL6_TEST_DIE_ON_FAIL
# or you can use it for one run like this:
PERL6_TEST_DIE_ON_FAIL=1 perl6 bob.t
````

Or in Windows:

````
SET PERL6_TEST_DIE_ON_FAIL=1
REM now all the follow up runs will stop at the first failure
perl6 bob.t
REM until we do
set PERL6_TEST_DIE_ON_FAIL=
````

For more information see the [Testing chapter of the Perl 6 Documentation](https://docs.perl6.org/language/testing.html).
