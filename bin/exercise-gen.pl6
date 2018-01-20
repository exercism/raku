#!/usr/bin/env perl6
use v6;
use YAML::Parser::LibYAML;
use lib (my $base-dir = $?FILE.IO.resolve.parent.parent).add('lib');
use Exercism::Generator;

my %*SUB-MAIN-OPTS = :named-anywhere;

proto sub MAIN (|) {
  if $base-dir.add('problem-specifications') !~~ :d {
    note 'problem-specifications directory not found; some exercises may generate incorrectly.';
  }
  if $base-dir.add('bin/configlet') !~~ :f {
    note 'configlet not found; README.md file(s) will not be generated.';
  }
  {*}
}

multi sub MAIN (Bool:D :$all where *.so) {
  generate .basename for $base-dir.add('exercises').dir;
}

multi sub MAIN (*@exercises) {
  @exercises».&generate;
}

multi sub MAIN {
  say 'No args given; working in current directory.';
  if 'example.yaml'.IO ~~ :f {
    generate $*CWD.IO.basename;
  } else {
    say 'example.yaml not found in current directory; exiting.';
    exit;
  }
}

my @dir-not-found;
my @yaml-not-found;

sub generate ($exercise) {
  if (my $exercise-dir = $base-dir.add("exercises/$exercise")) !~~ :d {
    push @dir-not-found, $exercise;
    next;
  }
  if (my $yaml-file = $exercise-dir.add('example.yaml')) !~~ :f {
    push @yaml-not-found, $exercise;
    next;
  };
  print "Generating $exercise... ";

  given Exercism::Generator.new: :$exercise, data => yaml-parse $yaml-file.absolute {
    given $exercise-dir.add("$exercise.t") -> $testfile {
      $testfile.spurt: .test;
      $testfile.chmod: 0o755;
    }
    $exercise-dir.add('Example.pm6').spurt: .example;
    $exercise-dir.add("{.data<exercise>}.pm6").spurt: .stub;
  }

  given $base-dir.add('bin/configlet') {
    if $_ ~~ :f {
      run .absolute, 'generate', $base-dir, '--only', $exercise;
    }
  }

  say 'Generated.';
}

if @dir-not-found  {warn 'exercise directory does not exist for: ' ~ join ' ', @dir-not-found}
if @yaml-not-found {note 'example.yaml not found for: ' ~ join ' ', @yaml-not-found}
