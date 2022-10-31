unit class Exercism::Generator;

use MONKEY-SEE-NO-EVAL;
use nqp;
use Config::TOML;
use JSON::Fast;
use Template::Mustache;
use YAMLish;

my $base-dir = $?FILE.IO.parent.add('../..');

#| The exercise slug
has Str:D $.exercise is required;
#= e.g. hello-world

#| The data to be used for rendering templates
has %.data = do if ( my $yaml-file =
  $base-dir.add("exercises/practice/$!exercise/.meta/template-data.yaml")
).f {
  load-yaml($yaml-file.slurp);
};

#| The parsed canonical-data.json from problem-specifications
has %.cdata = do if ( my $cdata-file =
  %*ENV<HOME>.IO.add(".cache/exercism/configlet/problem-specifications/exercises/$!exercise/canonical-data.json")
).f {
  from-json($cdata-file.slurp);
};

#| The case UUIDs to use from cdata
has Str:D @.case-uuids = do if (
  my $toml-file = $base-dir.add("exercises/practice/$!exercise/.meta/tests.toml")
).f {
  given from-toml($toml-file.slurp) {
    # TODO: Remove old toml format
    when .<canonical-tests>:exists {
      .<canonical-tests>.Set.keys;
    }

    default {
      .grep({ .value.<include>:!exists || .value.<include> }).map(*.key);
    }
  }
} #= e.g. [ '00000000-0000-0000-0000-000000000000' ]
;

#| An array of cases matching case-uuids
has Hash:D @.cases = self.build-cases(%!cdata);

#| The JSON of test cases to be used in the test suite
has Str:D $.json-tests = @!cases ?? to-json( @!cases, :sorted-keys ) !! '';

#| The test cases generated for individual properties
has Str:D @.property-tests = self.build-property-tests;

# Retrieves cases from cdata which match case UUIDs
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

submethod build-property-tests {
  my @tests;
  for self.cases -> %case {
    with self.data.<properties>{%case<property>}<test> -> $eval {
      @tests.push(EVAL $eval);
    }
  }
  return @tests;
}

#| The package name
method package ( --> Str:D ) {
  %.data<package> // $.exercise.split('-').map(&tclc).join;
}
#= e.g. HelloWorld

#| A rendered test suite
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
  if %data<properties> {
    %data<tests> ~= ("\n" if %data<tests>) ~ self.property-tests.join("\n").trim;
    %data<cases> = Nil;
  }

  Template::Mustache.render(
    $base-dir.add(
      "templates/{$module_file.defined ?? 'module' !! 'test'}.mustache"
    ).slurp,
    %( |%data, :$module_file )
  );
}

#| Renders the templates and creates the files for the exercise
method create-files ( --> Nil ) {
  my $exercise-dir = $base-dir.add("exercises/practice/$.exercise").mkdir;

  # Test
  my $testfile = $exercise-dir.add("$.exercise.rakutest");
  $testfile.spurt($.test);
  $testfile.chmod(0o755);

  # Stub
  $exercise-dir.add("$.package.rakumod").spurt($.stub);

  # Examples
  for $.examples.pairs -> $example {
    if $example.key eq 'base' {
      ( my $solution-dir = $exercise-dir
        .add('.meta/solutions') )
        .mkdir
        .add("$.package.rakumod")
        .spurt($example.value);
      # This emulates Raku's symlink, which does not yet support non-absolute paths
      try nqp::symlink(
        "../../$_",
        nqp::unbox_s( $solution-dir.add($_).absolute )
      ) given $testfile.basename;
    }
    else {
      ( my $solution-dir = $exercise-dir
        .add(".meta/solutions/{$example.key}") )
        .mkdir
        .add("$.package.rakumod")
        .spurt($example.value);
      # This emulates Raku's symlink, which does not yet support non-absolute paths
      try nqp::symlink(
        "../../../$_",
        nqp::unbox_s( $solution-dir.add($_).absolute )
      ) given $testfile.basename;
    }
  }
}
