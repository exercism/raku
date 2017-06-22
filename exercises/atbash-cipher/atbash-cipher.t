#!/usr/bin/env perl6
use v6;
use Test;
use lib my $dir = $?FILE.IO.dirname;

my $exercise = 'AtbashCipher';
my $version = v1;
my $module = %*ENV<EXERCISM> ?? 'Example' !! $exercise;
plan 4;

use-ok $module or bail-out;
require ::($module);

if ::($exercise).^ver !~~ $version {
  warn "\nExercise version mismatch. Further tests may fail!"
    ~ "\n$exercise is $(::($exercise).^ver.gist). "
    ~ "Test is $($version.gist).\n";
  bail-out 'Example version must match test version.' if %*ENV<EXERCISM>;
}

require ::($module) <&encode &decode>;

my $c-data;
for @($c-data<cases>) {
  my $test = .<description> ~~ 'encode' ?? 'encode' !! 'decode';
  subtest $test => {
    my @cases = |.<cases>;
    plan +@cases;
    is &::($test)(.<phrase>), |.<expected description> for @cases;
  }
}

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
          description => "encode yes".Str,
          expected    => "bvh".Str,
          phrase      => "yes".Str,
          property    => "encode".Str,
        },
        {
          description => "encode no".Str,
          expected    => "ml".Str,
          phrase      => "no".Str,
          property    => "encode".Str,
        },
        {
          description => "encode OMG".Str,
          expected    => "lnt".Str,
          phrase      => "OMG".Str,
          property    => "encode".Str,
        },
        {
          description => "encode spaces".Str,
          expected    => "lnt".Str,
          phrase      => "O M G".Str,
          property    => "encode".Str,
        },
        {
          description => "encode mindblowingly".Str,
          expected    => "nrmwy oldrm tob".Str,
          phrase      => "mindblowingly".Str,
          property    => "encode".Str,
        },
        {
          description => "encode numbers".Str,
          expected    => "gvhgr mt123 gvhgr mt".Str,
          phrase      => "Testing,1 2 3, testing.".Str,
          property    => "encode".Str,
        },
        {
          description => "encode deep thought".Str,
          expected    => "gifgs rhurx grlm".Str,
          phrase      => "Truth is fiction.".Str,
          property    => "encode".Str,
        },
        {
          description => "encode all the letters".Str,
          expected    => "gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt".Str,
          phrase      => "The quick brown fox jumps over the lazy dog.".Str,
          property    => "encode".Str,
        },
      ],
      comments    => [
        "Test encoding from English to atbash".Str,
      ],
      description => "encode".Str,
    },
    {
      cases       => [
        {
          description => "decode exercism".Str,
          expected    => "exercism".Str,
          phrase      => "vcvix rhn".Str,
          property    => "decode".Str,
        },
        {
          description => "decode a sentence".Str,
          expected    => "anobstacleisoftenasteppingstone".Str,
          phrase      => "zmlyh gzxov rhlug vmzhg vkkrm thglm v".Str,
          property    => "decode".Str,
        },
        {
          description => "decode numbers".Str,
          expected    => "testing123testing".Str,
          phrase      => "gvhgr mt123 gvhgr mt".Str,
          property    => "decode".Str,
        },
        {
          description => "decode all the letters".Str,
          expected    => "thequickbrownfoxjumpsoverthelazydog".Str,
          phrase      => "gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt".Str,
          property    => "decode".Str,
        },
      ],
      comments    => [
        "Test decoding from atbash to English".Str,
      ],
      description => "decode".Str,
    },
  ],
  comments => [
    "The tests are divided into two groups: ".Str,
    "* Encoding from English to atbash cipher".Str,
    "* Decoding from atbash cipher to all-lowercase-mashed-together English".Str,
  ],
  exercise => "atbash-cipher".Str,
  version  => "1.0.0".Str,
} }
