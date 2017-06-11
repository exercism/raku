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
  say "Generating $exercise...";
  my $exercise-dir = $base-dir.child("exercises/$exercise");
  next if (my $yaml = $exercise-dir.child('example.yaml')) !~~ :f;

  my %data = load-yaml $yaml.slurp;
  $_=.chomp when Str for @(%data.values);

  my $cdata = $base-dir.child("x-common/exercises/$exercise/canonical-data.json");
  %data<cdata> = :json($cdata.slurp) if $cdata ~~ :f;

  create-file "$exercise.t", 'test';

  %data<module_file> = %data<example>;
  create-file |<Example.pm6 module>;

  %data<module_file> = %data<stub>;
  create-file "{%data<exercise>}.pm6", 'module';

  say "$exercise generated.";

  sub create-file ($filename, $template) {
    spurt (my $file = $exercise-dir.child($filename)),
      Template::Mustache.render($base-dir.child("templates/$template.mustache").slurp, %data);
    $file.chmod(0o755) if $template ~~ 'test';
  }
}
