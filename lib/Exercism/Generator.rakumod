unit class Exercism::Generator;

use Config::TOML;
use JSON::Fast;
use Template::Mustache;

my $base-dir = $?FILE.IO.parent.add('../..');

has Str    $.exercise;
has        %.data       is rw;
has        @.case-uuids is SetHash;
has Str:D  $.cdata      = '';
has Hash:D @.cases;
has Str:D  $.json-tests = '';

submethod TWEAK {
  if @!case-uuids.not && $!exercise && ( my $toml-file =
    $base-dir.add("exercises/practice/$!exercise/.meta/tests.toml")
  ) ~~ :f {
    @!case-uuids = |from-toml($toml-file.slurp)<canonical-tests>;
  }

  if $!cdata.not && $!exercise && (
    my $cdata-file = $base-dir.add(
      ".problem-specifications/exercises/$!exercise/canonical-data.json"
    )
  ) ~~ :f {
    $!cdata = $cdata-file.slurp.trim;
  }

  if @!case-uuids && $!cdata {
    @!cases      = self.build-cases( from-json($!cdata) );
    $!json-tests = to-json( @!cases, :sorted-keys );
  }
}

#| Retrieves cases from cdata which match case UUIDs
submethod build-cases ( %obj, Str $description = '' ) {
  my Str $new-desc = '';
  if %obj<cases>.defined {
    if %obj<description> {
      $new-desc = $description ~ %obj<description>
        ~ ( %obj<description> ~~ /':' $/ ?? ' ' !! ': ' );
    }

    return %obj<cases>.map({
      self.&?ROUTINE( $_, $new-desc || $description )
    }).flat;
  }
  elsif %obj<uuid> ∈ @!case-uuids {
    return %(
      |( %obj<input expected property>:p ),
      :description($description ~ %obj<description>),
    ).item;
  }

  return;
}

#| The package name
method package ( --> Str:D ) {
  %.data<package> // $.exercise.split('-').map(&tclc).join;
}

#| A rendered test file
method test ( --> Str:D ) {
  self!render;
}

#| A rendered solution stub
method stub ( --> Str:D ) {
  self!render( %.data<stub> || '' );
}

#| A hash of rendered example solutions
method examples ( --> Hash() ) {
  return %.data<examples>
    ?? %.data<examples>.map({ .key => self!render(.value) })
    !! base => self!render(%.data<example>);
}

method !render ( Str $module_file? --> Str:D ) {
  my %data = %.data;
  %data<cases>   //= $.json-tests;
  %data<package> //= $.package;

  Template::Mustache.render(
    $base-dir.add(
      "templates/{$module_file.defined ?? 'module' !! 'test'}.mustache"
    ).slurp,
    %( |%data, :$module_file )
  );
}
