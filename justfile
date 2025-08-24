setup:
  bin/fetch-configlet
  zef install --deps-only .

create-practice-exercise slug author diff='1':
  bin/configlet create --practice-exercise {{slug}} --author {{author}} --difficulty {{diff}}

generate-practice-exercise slug:
  bin/configlet sync --exercise {{slug}} --update --docs --filepaths --metadata --tests choose
  bin/exercise-gen.raku {{slug}}

test-practice-example slug:
  prove -re raku exercises/practice/{{slug}}/.meta/solutions/

test-practice-stub slug:
  prove -re raku exercises/practice/{{slug}}/
