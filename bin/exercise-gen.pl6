#!/usr/bin/env perl6
use v6;
use Template::Mustache;
use YAMLish;

my $base-dir = $?FILE.IO.resolve.parent.parent;
my @exercises;

if @*ARGS {
  if @*ARGS[0] eq '--all' {
    push @exercises, .basename for $base-dir.child('exercises').dir;
  } else {
    @exercises = @*ARGS;
  }
} else {
  say 'No args given; working in current directory.';
  if 'example.yaml'.IO ~~ :f {
    push @exercises, $*CWD.IO.basename;
  } else {
    say 'example.yaml not found; exiting.';
    exit;
  }
}

for @exercises -> $exercise {
  my $exercise-dir = $base-dir.child("exercises/$exercise");
  if (my $yaml = $exercise-dir.child('example.yaml')) !~~ :f {
    say "No example.yaml found for $exercise.";
    next;
  };
  print "Generating $exercise... ";

  my %data = load-yaml $yaml.slurp;
  $_=.chomp when Str for @(%data.values);

  my $cdata = $base-dir.child("problem-specifications/exercises/$exercise/canonical-data.json");
  if $cdata ~~ :f {%data<cdata><json> = $cdata.slurp}

  create-file "$exercise.t", 'test';

  %data<module_file> = %data<example>;
  create-file |<Example.pm6 module>;

  %data<module_file> = %data<stub>;
  create-file "{%data<exercise>}.pm6", 'module';

  say 'Generated.';

  sub create-file ($filename, $template) {
    spurt (my $file = $exercise-dir.child($filename)),
      Template::Mustache.render($base-dir.child("templates/$template.mustache").slurp, %data);
    $file.chmod(0o755) if $template ~~ 'test';
  }
}
