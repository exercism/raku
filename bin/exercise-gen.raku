#!/usr/bin/env raku
use YAMLish;
use nqp;
use lib ( my $base-dir = $?FILE.IO.resolve.parent(2) ).add('lib');
use Exercism::Generator;

my %*SUB-MAIN-OPTS = :named-anywhere;

note "`problem-specifications` directory not found; exercise(s) may generate incorrectly.\nRun `bin/configlet sync` to sync data."
  unless %*ENV<HOME>.IO.add('.cache/exercism/configlet/problem-specifications').d;

#| Displays this message.
multi MAIN ( Bool:D :h(:help(:$man)) ) {
  say $*USAGE;
}

#| Runs the generator for everything in the exercises/practice directory.
multi MAIN (Bool:D :a(:$all) where *.so) {
  generate .basename for $base-dir.add('exercises/practice').dir;
}

#| The generator will run for each exercise given as an argument.
multi MAIN (*@exercises) {
  @exercises».&generate;
}

#|[The generator will attempt to run using the current directory.
Exits if a '.meta/template-data.yaml' file is not found.]
multi MAIN {
  say 'No args given; working in current directory.';
  if '.meta/template-data.yaml'.IO.f {
    generate $*CWD.IO.basename;
  } else {
    say "template-data.yaml not found in .meta of current directory; exiting.\n";
    say $*USAGE;
    exit 1;
  }
}

sub generate ($exercise) {
  state ( @dir-not-found, @yaml-not-found );
  END {
    if @dir-not-found {
      note 'exercise directory does not exist for: '  ~ join ' ', @dir-not-found
    }
    if @yaml-not-found {
      note '.meta/template-data.yaml not found for: ' ~ join ' ', @yaml-not-found
    }
  }
  if (
    my $exercise-dir = $base-dir.add("exercises/practice/$exercise")
  ) !~~ :d {
    push @dir-not-found, $exercise;
    return;
  }
  if (
    my $yaml-file = $exercise-dir.add('.meta/template-data.yaml')
  ) !~~ :f {
    push @yaml-not-found, $exercise;
    return;
  }

  print "Generating $exercise... ";

  Exercism::Generator.new(:$exercise).create-files;

  say 'Generated.';
}
