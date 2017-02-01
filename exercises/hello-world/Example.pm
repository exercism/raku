unit module HelloWorld:ver<1>;

sub hello (Str $name? --> Str:D) is export {
  'Hello, ' ~ ($name ?? $name !! 'World') ~ '!'
}
