unit class Exercism::Generator;
use Template::Mustache;
use JSON::Fast;
use META6;

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

method meta6 (--> META6) {
  META6.new(
    :auth<github:exercism>,
    :description(
      $base-dir.add("problem-specifications/exercises/$!exercise/description.md")
        .slurp.match(/^ .+? \.\D /).trim.lines.join(' ')
    ),
    :license<MIT>,
    :meta-version( v1 ),
    :name( %!data<exercise> ),
    :perl-version( v6.* ),
    :provides( %!data<exercise> => %!data<exercise> ~ '.pm6' ),
    :support( META6::Support.new(
      :bugtracker<https://github.com/exercism/perl6/issues>,
      :source<https://github.com/exercism/perl6>,
    ) ),
    :test-depends( [
      'JSON::Fast' x $!cdata.so,
      %!data<modules>.map( *.<use> ).Slip,
    ].grep(*.so) ),
    :version( Version.new( $!cdata.so ?? from-json($!cdata)<version> !! '' ) ),
  );
}

method !render (Str $module_file? --> Str:D) {
  Template::Mustache.render(
    $base-dir.add("templates/{$module_file.defined ?? 'module' !! 'test'}.mustache").slurp, %(|%!data, :$module_file)
  );
}
