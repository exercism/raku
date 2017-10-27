#!/usr/bin/env perl6
use v6;
use Template::Mustache;
use YAML::Parser::LibYAML;

my $base-dir = $?FILE.IO.resolve.parent.parent;
my @exercises;

if $base-dir.child('problem-specifications') !~~ :d {
  warn 'problem-specifications directory not found; some exercises may generate incorrectly.';
}

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
    say 'example.yaml not found in current directory; exiting.';
    exit;
  }
}

my @dir-not-found;
my @yaml-not-found;
for @exercises -> $exercise {
  if (my $exercise-dir = $base-dir.child("exercises/$exercise")) !~~ :d {
    push @dir-not-found, $exercise;
    next;
  }
  if (my $yaml-file = $exercise-dir.child('example.yaml')) !~~ :f {
    push @yaml-not-found, $exercise;
    next;
  };
  print "Generating $exercise... ";

  my %data = yaml-parse $yaml-file.absolute;

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

if @dir-not-found  {warn 'exercise directory does not exist for: ' ~ join ' ', @dir-not-found}
if @yaml-not-found {note 'example.yaml not found for: ' ~ join ' ', @yaml-not-found}
