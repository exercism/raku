#!/usr/bin/env perl6
use v6;
use Test;
use lib my $dir = $?FILE.IO.dirname;

my $exercise = 'Clock';
my $version = v1;
my $module = %*ENV<EXERCISM> ?? 'Example' !! $exercise;
plan 54;

use-ok $module or bail-out;
require ::($module);

if ::($exercise).^ver !~~ $version {
  warn "\nExercise version mismatch. Further tests may fail!"
    ~ "\n$exercise is $(::($exercise).^ver.gist). "
    ~ "Test is $($version.gist).\n";
  bail-out 'Example version must match test version.' if %*ENV<EXERCISM>;
}

subtest 'Class methods', {
  ok ::($exercise).can($_), $_ for <time add-minutes>;
}

my $c-data;
for @($c-data<cases>) {
  for @(.<cases>) -> $case {
    given $case<property> {
      when 'create' {
        is ::($exercise).new(hour => $case<hour>, minute => $case<minute>).?time, |$case<expected description>;
      }
      when 'add' {
        my $clock = ::($exercise).new(hour => $case<hour>, minute => $case<minute>);
        $clock.?add-minutes($case<add>);
        is $clock.?time, |$case<expected description>;
      }
      when 'equal' {
        is ::($exercise).new(hour => $case<clock1><hour>, minute => $case<clock1><minute>).?time eq
           ::($exercise).new(hour => $case<clock2><hour>, minute => $case<clock2><minute>).?time,
           |$case<expected description>;
      }
      when %*ENV<EXERCISM>.so { bail-out "no case for property '$case<property>'" }
    }
  }
}

todo 'optional test' unless %*ENV<EXERCISM>;
is ::($exercise).new(:0hour,:0minute).?add-minutes(65).?time, '01:05', 'add-minutes method can be chained';

if %*ENV<EXERCISM> {
  if (my $c-data-file = "$dir/../../x-common/exercises/{$dir.IO.resolve.basename}/canonical-data.json".IO.resolve) ~~ :f {
    is-deeply $c-data, EVAL('use JSON::Fast; from-json($c-data-file.slurp);'), 'canonical-data';
  } else { flunk 'canonical-data' }
} else { skip }

done-testing;

INIT { $c-data := {
  cases    => [
    {
      cases       => [
        {
          description => "on the hour".Str,
          expected    => "08:00".Str,
          hour        => 8.Int,
          minute      => 0.Int,
          property    => "create".Str,
        },
        {
          description => "past the hour".Str,
          expected    => "11:09".Str,
          hour        => 11.Int,
          minute      => 9.Int,
          property    => "create".Str,
        },
        {
          description => "midnight is zero hours".Str,
          expected    => "00:00".Str,
          hour        => 24.Int,
          minute      => 0.Int,
          property    => "create".Str,
        },
        {
          description => "hour rolls over".Str,
          expected    => "01:00".Str,
          hour        => 25.Int,
          minute      => 0.Int,
          property    => "create".Str,
        },
        {
          description => "hour rolls over continuously".Str,
          expected    => "04:00".Str,
          hour        => 100.Int,
          minute      => 0.Int,
          property    => "create".Str,
        },
        {
          description => "sixty minutes is next hour".Str,
          expected    => "02:00".Str,
          hour        => 1.Int,
          minute      => 60.Int,
          property    => "create".Str,
        },
        {
          description => "minutes roll over".Str,
          expected    => "02:40".Str,
          hour        => 0.Int,
          minute      => 160.Int,
          property    => "create".Str,
        },
        {
          description => "minutes roll over continuously".Str,
          expected    => "04:43".Str,
          hour        => 0.Int,
          minute      => 1723.Int,
          property    => "create".Str,
        },
        {
          description => "hour and minutes roll over".Str,
          expected    => "03:40".Str,
          hour        => 25.Int,
          minute      => 160.Int,
          property    => "create".Str,
        },
        {
          description => "hour and minutes roll over continuously".Str,
          expected    => "11:01".Str,
          hour        => 201.Int,
          minute      => 3001.Int,
          property    => "create".Str,
        },
        {
          description => "hour and minutes roll over to exactly midnight".Str,
          expected    => "00:00".Str,
          hour        => 72.Int,
          minute      => 8640.Int,
          property    => "create".Str,
        },
        {
          description => "negative hour".Str,
          expected    => "23:15".Str,
          hour        => -1.Int,
          minute      => 15.Int,
          property    => "create".Str,
        },
        {
          description => "negative hour rolls over".Str,
          expected    => "23:00".Str,
          hour        => -25.Int,
          minute      => 0.Int,
          property    => "create".Str,
        },
        {
          description => "negative hour rolls over continuously".Str,
          expected    => "05:00".Str,
          hour        => -91.Int,
          minute      => 0.Int,
          property    => "create".Str,
        },
        {
          description => "negative minutes".Str,
          expected    => "00:20".Str,
          hour        => 1.Int,
          minute      => -40.Int,
          property    => "create".Str,
        },
        {
          description => "negative minutes roll over".Str,
          expected    => "22:20".Str,
          hour        => 1.Int,
          minute      => -160.Int,
          property    => "create".Str,
        },
        {
          description => "negative minutes roll over continuously".Str,
          expected    => "16:40".Str,
          hour        => 1.Int,
          minute      => -4820.Int,
          property    => "create".Str,
        },
        {
          description => "negative hour and minutes both roll over".Str,
          expected    => "20:20".Str,
          hour        => -25.Int,
          minute      => -160.Int,
          property    => "create".Str,
        },
        {
          description => "negative hour and minutes both roll over continuously".Str,
          expected    => "22:10".Str,
          hour        => -121.Int,
          minute      => -5810.Int,
          property    => "create".Str,
        },
      ],
      description => "Create a new clock with an initial time".Str,
    },
    {
      cases       => [
        {
          add         => 3.Int,
          description => "add minutes".Str,
          expected    => "10:03".Str,
          hour        => 10.Int,
          minute      => 0.Int,
          property    => "add".Str,
        },
        {
          add         => 0.Int,
          description => "add no minutes".Str,
          expected    => "06:41".Str,
          hour        => 6.Int,
          minute      => 41.Int,
          property    => "add".Str,
        },
        {
          add         => 40.Int,
          description => "add to next hour".Str,
          expected    => "01:25".Str,
          hour        => 0.Int,
          minute      => 45.Int,
          property    => "add".Str,
        },
        {
          add         => 61.Int,
          description => "add more than one hour".Str,
          expected    => "11:01".Str,
          hour        => 10.Int,
          minute      => 0.Int,
          property    => "add".Str,
        },
        {
          add         => 160.Int,
          description => "add more than two hours with carry".Str,
          expected    => "03:25".Str,
          hour        => 0.Int,
          minute      => 45.Int,
          property    => "add".Str,
        },
        {
          add         => 2.Int,
          description => "add across midnight".Str,
          expected    => "00:01".Str,
          hour        => 23.Int,
          minute      => 59.Int,
          property    => "add".Str,
        },
        {
          add         => 1500.Int,
          description => "add more than one day (1500 min = 25 hrs)".Str,
          expected    => "06:32".Str,
          hour        => 5.Int,
          minute      => 32.Int,
          property    => "add".Str,
        },
        {
          add         => 3500.Int,
          description => "add more than two days".Str,
          expected    => "11:21".Str,
          hour        => 1.Int,
          minute      => 1.Int,
          property    => "add".Str,
        },
      ],
      description => "Add minutes".Str,
    },
    {
      cases       => [
        {
          add         => -3.Int,
          description => "subtract minutes".Str,
          expected    => "10:00".Str,
          hour        => 10.Int,
          minute      => 3.Int,
          property    => "add".Str,
        },
        {
          add         => -30.Int,
          description => "subtract to previous hour".Str,
          expected    => "09:33".Str,
          hour        => 10.Int,
          minute      => 3.Int,
          property    => "add".Str,
        },
        {
          add         => -70.Int,
          description => "subtract more than an hour".Str,
          expected    => "08:53".Str,
          hour        => 10.Int,
          minute      => 3.Int,
          property    => "add".Str,
        },
        {
          add         => -4.Int,
          description => "subtract across midnight".Str,
          expected    => "23:59".Str,
          hour        => 0.Int,
          minute      => 3.Int,
          property    => "add".Str,
        },
        {
          add         => -160.Int,
          description => "subtract more than two hours".Str,
          expected    => "21:20".Str,
          hour        => 0.Int,
          minute      => 0.Int,
          property    => "add".Str,
        },
        {
          add         => -160.Int,
          description => "subtract more than two hours with borrow".Str,
          expected    => "03:35".Str,
          hour        => 6.Int,
          minute      => 15.Int,
          property    => "add".Str,
        },
        {
          add         => -1500.Int,
          description => "subtract more than one day (1500 min = 25 hrs)".Str,
          expected    => "04:32".Str,
          hour        => 5.Int,
          minute      => 32.Int,
          property    => "add".Str,
        },
        {
          add         => -3000.Int,
          description => "subtract more than two days".Str,
          expected    => "00:20".Str,
          hour        => 2.Int,
          minute      => 20.Int,
          property    => "add".Str,
        },
      ],
      description => "Subtract minutes".Str,
    },
    {
      cases       => [
        {
          clock1      => {
            hour   => 15.Int,
            minute => 37.Int,
          },
          clock2      => {
            hour   => 15.Int,
            minute => 37.Int,
          },
          description => "clocks with same time".Str,
          expected    => Bool::True.Bool,
          property    => "equal".Str,
        },
        {
          clock1      => {
            hour   => 15.Int,
            minute => 36.Int,
          },
          clock2      => {
            hour   => 15.Int,
            minute => 37.Int,
          },
          description => "clocks a minute apart".Str,
          expected    => Bool::False.Bool,
          property    => "equal".Str,
        },
        {
          clock1      => {
            hour   => 14.Int,
            minute => 37.Int,
          },
          clock2      => {
            hour   => 15.Int,
            minute => 37.Int,
          },
          description => "clocks an hour apart".Str,
          expected    => Bool::False.Bool,
          property    => "equal".Str,
        },
        {
          clock1      => {
            hour   => 10.Int,
            minute => 37.Int,
          },
          clock2      => {
            hour   => 34.Int,
            minute => 37.Int,
          },
          description => "clocks with hour overflow".Str,
          expected    => Bool::True.Bool,
          property    => "equal".Str,
        },
        {
          clock1      => {
            hour   => 3.Int,
            minute => 11.Int,
          },
          clock2      => {
            hour   => 99.Int,
            minute => 11.Int,
          },
          description => "clocks with hour overflow by several days".Str,
          expected    => Bool::True.Bool,
          property    => "equal".Str,
        },
        {
          clock1      => {
            hour   => 22.Int,
            minute => 40.Int,
          },
          clock2      => {
            hour   => -2.Int,
            minute => 40.Int,
          },
          description => "clocks with negative hour".Str,
          expected    => Bool::True.Bool,
          property    => "equal".Str,
        },
        {
          clock1      => {
            hour   => 17.Int,
            minute => 3.Int,
          },
          clock2      => {
            hour   => -31.Int,
            minute => 3.Int,
          },
          description => "clocks with negative hour that wraps".Str,
          expected    => Bool::True.Bool,
          property    => "equal".Str,
        },
        {
          clock1      => {
            hour   => 13.Int,
            minute => 49.Int,
          },
          clock2      => {
            hour   => -83.Int,
            minute => 49.Int,
          },
          description => "clocks with negative hour that wraps multiple times".Str,
          expected    => Bool::True.Bool,
          property    => "equal".Str,
        },
        {
          clock1      => {
            hour   => 0.Int,
            minute => 1.Int,
          },
          clock2      => {
            hour   => 0.Int,
            minute => 1441.Int,
          },
          description => "clocks with minute overflow".Str,
          expected    => Bool::True.Bool,
          property    => "equal".Str,
        },
        {
          clock1      => {
            hour   => 2.Int,
            minute => 2.Int,
          },
          clock2      => {
            hour   => 2.Int,
            minute => 4322.Int,
          },
          description => "clocks with minute overflow by several days".Str,
          expected    => Bool::True.Bool,
          property    => "equal".Str,
        },
        {
          clock1      => {
            hour   => 2.Int,
            minute => 40.Int,
          },
          clock2      => {
            hour   => 3.Int,
            minute => -20.Int,
          },
          description => "clocks with negative minute".Str,
          expected    => Bool::True.Bool,
          property    => "equal".Str,
        },
        {
          clock1      => {
            hour   => 4.Int,
            minute => 10.Int,
          },
          clock2      => {
            hour   => 5.Int,
            minute => -1490.Int,
          },
          description => "clocks with negative minute that wraps".Str,
          expected    => Bool::True.Bool,
          property    => "equal".Str,
        },
        {
          clock1      => {
            hour   => 6.Int,
            minute => 15.Int,
          },
          clock2      => {
            hour   => 6.Int,
            minute => -4305.Int,
          },
          description => "clocks with negative minute that wraps multiple times".Str,
          expected    => Bool::True.Bool,
          property    => "equal".Str,
        },
        {
          clock1      => {
            hour   => 7.Int,
            minute => 32.Int,
          },
          clock2      => {
            hour   => -12.Int,
            minute => -268.Int,
          },
          description => "clocks with negative hours and minutes".Str,
          expected    => Bool::True.Bool,
          property    => "equal".Str,
        },
        {
          clock1      => {
            hour   => 18.Int,
            minute => 7.Int,
          },
          clock2      => {
            hour   => -54.Int,
            minute => -11513.Int,
          },
          description => "clocks with negative hours and minutes that wrap".Str,
          expected    => Bool::True.Bool,
          property    => "equal".Str,
        },
      ],
      description => "Compare two clocks for equality".Str,
    },
  ],
  comments => [
    "Most languages require constructing a clock with initial values,".Str,
    "adding a positive or negative number of minutes, and testing equality".Str,
    "in some language-native way.  Some languages require separate add and".Str,
    "subtract functions.  Negative and out of range values are generally".Str,
    "expected to wrap around rather than represent errors.".Str,
  ],
  exercise => "clock".Str,
  version  => "1.0.1".Str,
} }
