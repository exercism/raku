#!/usr/bin/env perl6
use v6;
use Test;
use JSON::Tiny;
use lib $?FILE.IO.dirname;

plan 12;
my $module = %*ENV<EXERCISM> ?? 'Example' !! 'Phone';
use-ok $module;
require ::($module) <Phone>;

my %cases;
subtest 'number, area-code and pretty methods', {
  plan 3;
  ok Phone.can('number'), 'can Phone.number';
  ok Phone.can('area-code'), 'can Phone.area-code';
  ok Phone.can('pretty'), 'can Phone.pretty';
} or fail 'Missing method(s).';

for @(%cases<valid>) {
  my $phone = Phone.new(number => .<input>);
  my $msg = 'for ' ~ .<test>;
  is $phone.number, .<number>, "number $msg";
  is $phone.area-code, .<area-code>, "area-code $msg";
  is $phone.pretty, .<pretty>, "pretty $msg";
}

todo 'Optional Exception Tests' unless %*ENV<EXERCISM>; # Remove this line for invalid input tests
subtest 'Throw exceptions for invalid input', {
  plan 5;
  throws-like {Phone.new(number => .<input>)}, Exception, .<test> for @(%cases<invalid>);
}

done-testing;

INIT {
  %cases := from-json ｢
    {
      "valid": [
        {
          "input": 1234567890,
          "number": "1234567890",
          "area-code": "123",
          "pretty": "(123) 456-7890",
          "test": "10 digit integer"
        },
        {
          "input": "+1 (234) 555-6789",
          "number": "2345556789",
          "area-code": "234",
          "pretty": "(234) 555-6789",
          "test": "11 digit formatted number"
        },
        {
          "input": "1.379.555.2468",
          "number": "3795552468",
          "area-code": "379",
          "pretty": "(379) 555-2468",
          "test": "11 digit number containing separators"
        }
      ],
      "invalid": [
        {
          "input": "",
          "test": "empty input"
        },
        {
          "input": "13579",
          "test": "5 digit number"
        },
        {
          "input": "123456789011",
          "test": "12 digit number"
        },
        {
          "input": "+2 (468) 555-1379",
          "test": "11 digit number not beginning with 1"
        },
        {
          "input": "phone number",
          "test": "not a number"
        }
      ]
    }
  ｣
}
