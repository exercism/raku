#!/usr/bin/env perl6
use v6;
use Test;
use JSON::Fast;
use lib $?FILE.IO.dirname; #`[Look for the module inside the same directory as this test file.]
use HelloWorld;
plan 1; #`[This is how many tests we expect to run.]

my $c-data = from-json $=pod.pop.contents;
# Loop over the cases array taken from the canonical data JSON below.
for @($c-data<cases>) -> %case {
  # Run the 'is' subroutine from the 'Test' module, with three arguments.
  is(
    hello,             # Run the 'hello' subroutine, which is imported from your module.
    %case<expected>,   # The expected result from canonical data to compare with 'hello'.
    %case<description> # The test description from canonical data.
  );
}

=head2 Canonical Data
=begin code
{
  "exercise": "hello-world",
  "version": "1.1.0",
  "cases": [
    {
      "description": "Say Hi!",
      "property": "hello",
      "input": {},
      "expected": "Hello, World!"
    }
  ]
}
=end code
