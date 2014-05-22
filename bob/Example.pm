class Bob {

    method hey ($input) {
            if    $input ~~ /^^\s*$$/                             { 'Fine. Be that way!' }
            elsif $input ~~ /<:Upper>/ and $input.uc eq $input    { 'Woah, chill out!'   }
            elsif $input ~~ /'?'$$/                               { 'Sure.'              }
            else                                                  { 'Whatever.'          }
        }
}
