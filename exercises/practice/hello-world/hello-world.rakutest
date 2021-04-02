#!/usr/bin/env raku
use Test;
use lib $?FILE.IO.dirname; #`[Look for the module inside the same directory as this test file.]
use HelloWorld;
plan 1; #`[This is how many tests we expect to run.]

# Run the 'is' subroutine from the 'Test' module, with three arguments.
is(
  hello,           # Run the 'hello' subroutine, which is imported from your module.
  'Hello, World!', # The expected result to compare with 'hello'.
  'Say Hi!'        # The test description.
);
