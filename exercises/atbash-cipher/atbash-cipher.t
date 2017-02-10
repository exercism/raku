#!/usr/bin/env perl6

use Test;
use JSON::Tiny;

use lib $?FILE.IO.dirname;

my $module = %*ENV<EXERCISM> ?? 'Example' !! 'Cipher';
require ::($module) <&encode &decode>;

plan 2;

my %cases;
subtest 'encode' => {
    my @cases = |%cases.<encode>.<cases>;

    plan +@cases;

    is encode( .<phrase> ), .<expected>, .<description>
        for @cases;
};

subtest 'decode' => {
    my @cases = |%cases.<decode>.<cases>;

    plan +@cases;

    is decode( .<phrase> ), .<expected>, .<description>
        for @cases;
};

done-testing;

INIT {
  %cases := from-json ｢
    {
      "#": [
        "The tests are divided into two groups: ",
        "* Encoding from English to atbash cipher",
        "* Decoding from atbash cipher to all-lowercase-mashed-together English"
      ],
      "encode": {
        "description": ["Test encoding from English to atbash"],
        "cases": [
          {
            "description": "encode yes",
            "phrase": "yes",
            "expected": "bvh"
          },
          {
            "description": "encode no",
            "phrase": "no",
            "expected": "ml"
          },
          {
            "description": "encode OMG",
            "phrase": "OMG",
            "expected": "lnt"
          },
          {
            "description": "encode spaces",
            "phrase": "O M G",
            "expected": "lnt"
          },
          {
            "description": "encode mindblowingly",
            "phrase": "mindblowingly",
            "expected": "nrmwy oldrm tob"
          },
          {
            "description": "encode numbers",
            "phrase": "Testing,1 2 3, testing.",
            "expected": "gvhgr mt123 gvhgr mt"
          },
          {
            "description": "encode deep thought",
            "phrase": "Truth is fiction.",
            "expected": "gifgs rhurx grlm"
          },
          {
            "description": "encode all the letters",
            "phrase": "The quick brown fox jumps over the lazy dog.",
            "expected": "gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt"
          },
          {
            "description": "encode ignores non ascii",
            "phrase": "non ascii éignored",
            "expected": "mlmzh xrrrt mlivw"
          }
        ]
      },
      "decode": {
        "description": ["Test decoding from atbash to English"],
        "cases": [
          {
              "description": "decode exercism",
              "phrase": "vcvix rhn",
              "expected": "exercism"
          },
          {
              "description": "decode a sentence",
              "phrase": "zmlyh gzxov rhlug vmzhg vkkrm thglm v",
              "expected": "anobstacleisoftenasteppingstone"
          },
          {
              "description": "decode numbers",
              "phrase": "gvhgr mt123 gvhgr mt",
              "expected": "testing123testing"
          },
          {
              "description": "decode all the letters",
              "phrase": "gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt",
              "expected": "thequickbrownfoxjumpsoverthelazydog"
          }
        ]
      }
    }
  ｣
}
