#`[
  Declare class 'Bob' with version and unit-scope the class
  i.e. everything in this file is part of 'Bob'.
]
unit class Bob:ver<1>;

method hey ($msg) {
  given $msg.trim {
    when !*                        { 'Fine. Be that way!' }
    when /<:Upper>/ and $_.uc eq * { 'Whoa, chill out!'   }
    when /'?'$/                    { 'Sure.'              }
    default                        { 'Whatever.'          }
  }
}
