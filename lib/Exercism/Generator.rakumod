unit class Exercism::Generator;

use Config::TOML;
use JSON::Fast;
use Template::Mustache;
use YAMLish;

my $base-dir = $?FILE.IO.parent.add('../..');

has Str:D $.exercise is required;

has %.data = do if ( my $yaml-file =
  $base-dir.add("exercises/practice/$!exercise/.meta/exercise-data.yaml")
).f {
  load-yaml($yaml-file.slurp);
};

has %.cdata = do if ( my $cdata-file =
  $base-dir.add(
    ".problem-specifications/exercises/$!exercise/canonical-data.json"
  )
).f {
  from-json($cdata-file.slurp);
};

has Str:D @.case-uuids = do if ( my $toml-file =
  $base-dir.add("exercises/practice/$!exercise/.meta/tests.toml")
).f {
  from-toml($toml-file.slurp)<canonical-tests>.Set.keys;
};

has Hash:D @.cases = self.build-cases(%!cdata);

has Str:D $.json-tests = @!cases ?? to-json( @!cases, :sorted-keys ) !! '';

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

  return Empty;
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
    ?? %.data<examples>.map({ .key => self!render( .value || '' ) })
    !! base => self!render( %.data<example> || '' );
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
