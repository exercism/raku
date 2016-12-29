#!/usr/bin/env perl6
use v6;
use Test;
use JSON::Tiny;
use lib my $path = IO::Path.new($?FILE).parent.path;

plan 12;
my $module = %*ENV<EXERCISM> ?? 'Example' !! 'Phone';
use-ok $module;
require ::($module) <Phone>;

my %tests = from-json open("$path/cases.json").slurp-rest;

subtest 'number, area-code and pretty methods', {
  plan 3;
  ok Phone.can('number'), 'can Phone.number';
  ok Phone.can('area-code'), 'can Phone.area-code';
  ok Phone.can('pretty'), 'can Phone.pretty';
} or fail 'Missing method(s).';

for @(%tests<valid>) {
  my $phone = Phone.new(number => .<input>);
  my $msg = 'for ' ~ .<test>;
  is $phone.number, .<number>, "number $msg";
  is $phone.area-code, .<area-code>, "area-code $msg";
  is $phone.pretty, .<pretty>, "pretty $msg";
}

todo 'Optional Exception Tests' unless %*ENV<EXERCISM>; # Remove this line for invalid input tests
subtest 'Throw exceptions for invalid input', {
  plan 5;
  throws-like {Phone.new(number => .<input>)}, Exception, .<test> for @(%tests<invalid>);
}
