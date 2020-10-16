#!/usr/bin/env raku
use Config::TOML;
use JSON::Fast;
use YAMLish;
use nqp;
use lib (my $base-dir = $?FILE.IO.resolve.parent.parent).add('lib');
use Exercism::Generator;

my %*SUB-MAIN-OPTS = :named-anywhere;

given $base-dir {
  note 'problem-specifications directory not found; exercise(s) may generate incorrectly.'
    unless .add('problem-specifications').d;

  note 'executable configlet not found; README.md file(s) will not be generated.'
    unless .add('bin/configlet').x;
}

#| Displays this message.
multi MAIN ( Bool:D :h(:help(:$man)) ) {
  say $*USAGE;
}

#| Runs the generator for everything in the exercises directory.
multi MAIN (Bool:D :a(:$all) where *.so) {
  generate .basename for $base-dir.add('exercises').dir;
}

#| The generator will run for each exercise given as an argument.
multi MAIN (*@exercises) {
  @exercises».&generate;
}

#|The generator will attempt to run using the current directory.
multi MAIN {
  say 'No args given; working in current directory.';
  generate $*CWD.IO.basename;
}

sub generate ($exercise) {
  state (@dir-not-found, @data-not-found);
  END {
    if @dir-not-found  {note 'exercise directory does not exist for: '  ~ join ' ', @dir-not-found}
    if @data-not-found {note '.meta/exercise-data.{toml,yaml,json} not found for: ' ~ join ' ', @data-not-found}
  }

  if (my $exercise-dir = $base-dir.add("exercises/$exercise")) !~~ :d {
    push @dir-not-found, $exercise;
    return;
  }

  my %data;
  if (my $toml-file = $exercise-dir.add('.meta/exercise-data.toml')) ~~ :f {
    %data = from-toml file => $toml-file.absolute;
  }
  elsif (my $yaml-file = $exercise-dir.add('.meta/exercise-data.yaml')) ~~ :f {
    %data = load-yaml $yaml-file.absolute.IO.slurp;
  }
  elsif (my $json-file = $exercise-dir.add('.meta/exercise-data.json')) ~~ :f {
    %data = from-json $json-file.absolute.IO.slurp;
  }
  else {
    push @data-not-found, $exercise;
    return;
  }

  print "Generating $exercise... ";

  given Exercism::Generator.new: :$exercise, :%data {
    my $testfile = $exercise-dir.add("$exercise.rakutest");
    $testfile.spurt: .test;
    $testfile.chmod: 0o755;

    $exercise-dir.add("{.data<exercise>}.rakumod").spurt: .stub;

    $exercise-dir.add('.meta/solutions').mkdir;
    for .examples.pairs -> $example {
      if $example.key ~~ 'base' {
        $exercise-dir.add(".meta/solutions/{.data<exercise>}.rakumod").spurt: $example.value;
        try nqp::symlink("../../$_", ~$exercise-dir.add(".meta/solutions/$_")) given $testfile.basename;
      }
      else {
        $exercise-dir.add(".meta/solutions/{$example.key}").mkdir;
        $exercise-dir.add(".meta/solutions/{$example.key}/{.data<exercise>}.rakumod").spurt: $example.value;
        try nqp::symlink("../../../$_", ~$exercise-dir.add(".meta/solutions/{$example.key}/$_")) given $testfile.basename;
      }
    }
  }

  given $base-dir.add('bin/configlet') {
    run .absolute, 'generate', $base-dir, '--only', $exercise if .x;
  }

  say 'Generated.';
}
