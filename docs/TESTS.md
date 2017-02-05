# Running the Tests

## Run All Tests

There is a Perl 6 script with the extension `.t`, which will be used to test
your solution. You can run through the tests by using the command:

`prove . --exec=perl6`

Before you start the exercise, the output will likely look something like:

```
./hello-world.t .. 1/6
# Failed test 'No argument'
# at ./hello-world.t line 28
# expected: 'Hello, World!'
#      got: (Nil)

# Failed test 'Empty string'
# at ./hello-world.t line 29
# expected: 'Hello, World!'
#      got: (Nil)
./hello-world.t .. Dubious, test returned 2 (wstat 512, 0x200)
Failed 2/6 subtests

Test Summary Report
-------------------
./hello-world.t (Wstat: 512 Tests: 6 Failed: 2)
  Failed tests:  3-4
  Non-zero exit status: 2
```
You will either need to modify or create a module with the extension `.pm6`, and
write a solution to pass the tests. Once the tests are passing, the output from
the command above will likely look something like:

```
./hello-world.t .. ok
All tests successful.
Files=1, Tests=6,  0 wallclock secs ( 0.03 usr  0.00 sys +  0.37 cusr  0.04 csys =  0.44 CPU)
Result: PASS
```

Some exercises may have optional tests. You can test for these by adding the
flag `-v` (for 'verbose') to the above command, like so:

`prove . --exec=perl6 -v`

The output will likely look something like:

```
./hello-world.t ..
1..6
ok 1 - The module can be use-d ok
    1..1
    ok 1 - &hello
ok 2 - Subroutine(s)
ok 3 - No argument
ok 4 - Empty string
not ok 5 - Camelia # TODO optional test

# Failed test 'Camelia'
# at ./hello-world.t line 31
# expected: 'Hello, Camelia!'
#      got: 'Hello, World!'
not ok 6 - Rakudo # TODO optional test

# Failed test 'Rakudo'
# at ./hello-world.t line 32
# expected: 'Hello, 楽土!'
#      got: 'Hello, World!'
ok
All tests successful.
Files=1, Tests=6,  1 wallclock secs ( 0.03 usr  0.00 sys +  0.58 cusr  0.06 csys =  0.67 CPU)
Result: PASS
```

## Stop After First Failure

If you have the `PERL6_TEST_DIE_ON_FAIL` environment variable set, the test
runner will stop after the first failure. For example:

In Linux / OS X:

```bash
export PERL6_TEST_DIE_ON_FAIL=1
# now all the follow up runs will stop at the first failure
prove . --exec=perl6
# until we do
unset PERL6_TEST_DIE_ON_FAIL
# or you can use it for one run like this:
PERL6_TEST_DIE_ON_FAIL=1 prove . --exec=perl6
```

Or in Windows:

```
SET PERL6_TEST_DIE_ON_FAIL=1
REM now all the follow up runs will stop at the first failure
prove . --exec=perl6
REM until we do
set PERL6_TEST_DIE_ON_FAIL=
```

For more information see the
[Testing chapter of the Perl 6 Documentation](https://docs.perl6.org/language/testing.html).
