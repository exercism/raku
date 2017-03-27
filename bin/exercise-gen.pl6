#!/usr/bin/env perl6
use v6;
use Template::Mustache;
use YAMLish;

my $base-dir = $?FILE.IO.resolve.parent.parent;
my @exercises;

if @*ARGS {
  if @*ARGS[0] eq '--all' {
    push @exercises, $_.basename for $base-dir.child('exercises').dir;
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
  next if (my $yaml = $exercise-dir.child('example.yaml')) !~~ :f;
  my $cdata = $base-dir.child("x-common/exercises/$exercise/canonical-data.json");
  my %data = load-yaml $yaml.slurp;
  %data<cdata> = {:json($cdata.slurp)} if $cdata ~~ :f;

  spurt (my $test = $exercise-dir.child("$exercise.t")),
    Template::Mustache.render($base-dir.child('templates/test.mustache').slurp, %data);
  $test.chmod(0o755);
  say "$exercise generated.";
}
