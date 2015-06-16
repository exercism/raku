class Bob {
    method hey ($input) {
        given $input {
            when /^\s*$/                            { 'Fine. Be that way!' }
            when /<:Upper>/ and $input.uc eq $input { 'Whoa, chill out!'   }
            when /'?'$/                             { 'Sure.'              }
            default                                 { 'Whatever.'          }
        }
    }
}
