unit class Exercism::Generator;
use Template::Mustache;

my $base-dir = $?FILE.IO.parent.add("../..");

has %.data;
has Str $.exercise;

submethod TWEAK {
  if $!exercise && (my $cdata =
    $base-dir.add: "problem-specifications/exercises/$!exercise/canonical-data.json") ~~ :f
  {
    %!data<cdata><json> = $cdata.slurp;
  }
}

method cdata {
  %!data<cdata><json> ?? %!data<cdata><json> !! '';
}

method test {
  self!render(template => 'test');
}

method stub {
  self!render(template => 'module', file => 'stub');
}

method example {
  self!render(template => 'module', file => 'example');
}

method !render (:$template!, :$file) {
  my $data = %!data;
  if $file { $data<module_file> = $data{$file} };
  Template::Mustache.render($base-dir.add("templates/$template.mustache").slurp, $data);
}
