#!/usr/bin/env perl6
use v6;
use Test;
use JSON::Tiny;
use lib my $path = IO::Path.new($?FILE).parent.path;

BEGIN {
  plan 12;
  use-ok %*ENV<EXERCISM> ?? 'Example' !! 'Phone', 'Module loaded';

  unless $*PERL.compiler.version ~~ v2016.10+ {
    sub bail-out {};
    note 'Perl 6 ' ~ $*PERL.compiler.version ~ ' is not supported. Please use v2016.10 or newer';
    skip-rest;
    exit;
  }
}

my %tests = from-json open("$path/cases.json").slurp-rest;

subtest 'number, area-code and pretty methods', {
  plan 3;
  ok Phone.can('number'), 'can Phone.number';
  ok Phone.can('area-code'), 'can Phone.area-code';
  ok Phone.can('pretty'), 'can Phone.pretty';
} or bail-out 'Missing method(s).';

for @(%tests<valid>) {
  my $phone = Phone.new(number => .<input>);
  my $msg = 'for ' ~ .<test>;
  is $phone.number, .<number>, "number $msg";
  is $phone.area-code, .<area-code>, "area-code $msg";
  is $phone.pretty, .<pretty>, "pretty $msg";
}

my $exception;
if %*ENV<EXERCISM> {
  $exception = X::Phone::Invalid;
}
else {
  todo 'Optional Exception Tests'; # Remove this line for invalid input tests
  $exception = Exception; # Change this if you wish to specify a specific exception
}

subtest 'Throw exceptions for invalid input', {
  plan 5;
  throws-like {Phone.new(number => .<input>)}, $exception, .<test> for @(%tests<invalid>);
}
