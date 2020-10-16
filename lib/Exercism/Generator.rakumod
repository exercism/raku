unit class Exercism::Generator;

use Config::TOML;
use JSON::Fast;
use Template::Mustache;

my $base-dir = $?FILE.IO.parent.add("../..");

has        %.data;
has Str    $.exercise;
has Str:D  $.cdata      = '';
has Str:D  $.json-tests = '';
has Hash:D @.cases;
has @.case-uuids is SetHash;

submethod TWEAK {
  if self.exercise {
    if (my $toml-file =
      $base-dir.add: "exercises/$(self.exercise)/.meta/tests.toml") ~~ :f
    {
      @!case-uuids = |from-toml($toml-file.slurp)<canonical-tests>;
    }

    if self.case-uuids && (my $cdata-file =
      $base-dir.add: "problem-specifications/exercises/$!exercise/canonical-data.json") ~~ :f
    {
      $!cdata = $cdata-file.slurp.trim;
      self!populate-cases( from-json(self.cdata) );
      %!data<cases> := $!json-tests = to-json(self.cases, :sorted-keys);
    }
  }
}

method !populate-cases ( %obj, Str $description = '' --> Nil ) {
  my Str $new-desc = '';
  if %obj<cases>.defined {
    if %obj<description> {
      $new-desc = $description ~ %obj<description>
        ~ ( %obj<description> ~~ /':' $/ ?? ' ' !! ': ' );
    }
    self!populate-cases( $_, $new-desc || $description ) for %obj<cases>.values;
  }
  elsif %obj<uuid> ∈ self.case-uuids {
    @!cases.push(
      %(|(%obj<input expected property>:p), description => $description ~ %obj<description>)
    );
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
