class Bob {
    method hey ($input) {
            if    $input ~~ /^\s*$/                             { 'Fine. Be that way!' }
            elsif $input ~~ /<:Upper>/ and $input.uc eq $input  { 'Whoa, chill out!'   }
            elsif $input ~~ /'?'$/                              { 'Sure.'              }
            else                                                { 'Whatever.'          }
        }
}
