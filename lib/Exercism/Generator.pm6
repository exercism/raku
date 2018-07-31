unit class Exercism::Generator;
use Template::Mustache;

my $base-dir = $?FILE.IO.parent.add("../..");

has %.data;
has Str $.exercise;
has Str:D $.cdata = '';

submethod TWEAK {
  if $!exercise && %!data<ignore_cdata>.not && (my $cdata-file =
    $base-dir.add: "problem-specifications/exercises/$!exercise/canonical-data.json") ~~ :f
  {
    %!data<cdata><json> := $!cdata = $cdata-file.slurp.trim;
  }
}

method test (--> Str:D) {
  self!render;
}

method stub (--> Str:D) {
  self!render: %!data<stub> || '';
}

method examples (--> Hash()) {
  return %!data<examples>
    ?? %!data<examples>.map: {.key => self!render: .value}
    !! base => self!render: %!data<example>;
}

method !render (Str $module_file? --> Str:D) {
  Template::Mustache.render(
    $base-dir.add("templates/{$module_file.defined ?? 'module' !! 'test'}.mustache").slurp, %(|%!data, :$module_file)
  );
}
