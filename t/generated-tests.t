#!/usr/bin/env perl6
use v6;
use Test;
use YAML::Parser::LibYAML;
use lib (my $base-dir = $?FILE.IO.resolve.parent.parent).add('lib');
use Exercism::Generator;

bail-out if $base-dir.add('problem-specifications') !~~ :d;
for $base-dir.add('exercises').dir {
  if .add('example.yaml') ~~ :f {
    todo '';
    is .add("{.basename}.t").slurp,
      Exercism::Generator.new(data => yaml-parse(~.add: 'example.yaml'), exercise => .basename).test,
      "{.basename}: test suite matches generated";
  }
}

done-testing;
