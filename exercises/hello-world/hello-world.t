#!/usr/bin/env perl6
use v6;
use Test;
use JSON::Fast;
use lib $?FILE.IO.dirname; #`[Look for the module inside the same directory as this test file.]
use HelloWorld;
plan 1; #`[This is how many tests we expect to run.]

my $c-data = from-json $=pod.pop.contents;
# Go through the cases and check that &hello gives us the correct response.
is hello, |.<expected description> for @($c-data<cases>);

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
