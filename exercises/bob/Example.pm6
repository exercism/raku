unit class Bob:ver<1>;

method hey ($msg) {
  given $msg.trim {
    when !*                        { 'Fine. Be that way!' }
    when /<:Upper>/ and $_.uc eq * { 'Whoa, chill out!'   }
    when /'?'$/                    { 'Sure.'              }
    default                        { 'Whatever.'          }
  }
}
