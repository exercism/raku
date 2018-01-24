#!/usr/bin/env perl6
use v6;
use YAML::Parser::LibYAML;
use lib (my $base-dir = $?FILE.IO.resolve.parent.parent).add('lib');
use Exercism::Generator;

given $base-dir {
  if .add('problem-specifications') !~~ :d {
    note 'problem-specifications directory not found; exercise(s) may generate incorrectly.';
  }
  if .add('bin/configlet') !~~ :f {
    note 'configlet not found; README.md file(s) will not be generated.';
  }
}

my $yaml-filename := '.meta/exercise-data.yaml';

my %*SUB-MAIN-OPTS = :named-anywhere;

multi MAIN (Bool:D :$all where *.so) {
  samewith $base-dir.add('exercises').dir».basename;
}

multi MAIN (*@exercises) {
  await @exercises.unique.map: {start .&generate};
}

multi MAIN {
  given $*CWD {
    say "No args given; looking for '$yaml-filename' in '$_'";
    if $yaml-filename.IO ~~ :f {
      generate .IO.basename;
    } else {
      say "'$yaml-filename' not found in '$_'; exiting.";
      exit;
    }
  }
}

sub generate (Str:D $exercise --> Nil) {
  state (@dir-not-found, @yaml-not-found);
  END {
    if @dir-not-found  {note 'exercise directory does not exist for: ' ~ join ' ', @dir-not-found}
    if @yaml-not-found {note "$yaml-filename not found for: " ~ join ' ', @yaml-not-found}
  }
  if (my $exercise-dir := $base-dir.add("exercises/$exercise")) !~~ :d {
    push @dir-not-found, $exercise;
    return;
  }
  if (my $yaml-file := $exercise-dir.add: $yaml-filename) !~~ :f {
    push @yaml-not-found, $exercise;
    return;
  }

  given Exercism::Generator.new(:$exercise, data => yaml-parse $yaml-file.absolute) -> $generated {
    given $exercise-dir {
      .add(my $module := "{$generated.data<exercise>}.pm6").spurt: $generated.stub;
      given .add('.meta/solutions') {
        .mkdir;
        .add($module).spurt: $generated.example;
      }
      given .add("$exercise.t") {
        .spurt: $generated.test;
        .chmod: 0o755;
      }
    }
  }

  given $base-dir.add('bin/configlet') {
    run .absolute, 'generate', $base-dir, '--only', $exercise when :f;
  }

  say "generated $exercise";
}
