#`[
  Declare class 'Bob' with version and unit-scope the class
  i.e. everything in this file is part of 'Bob'.
]
unit class Bob:ver<2>;

method hey ( Str:D $_ --> Str:D ) {
  my \shouting = /<:L>/ ^ /<:Ll>/;
  given .trim {
    when .ends-with: ‘?’  {
      when shouting { ‘Calm down, I know what I'm doing!’ }
      default       { ‘Sure.’ }
    }
    when shouting { ‘Whoa, chill out!’ }
    when .not     { ‘Fine. Be that way!’ }
    default       { ‘Whatever.’ };
  }
}
