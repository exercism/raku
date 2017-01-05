sub encode($input) is export {
    decode($input.lc.trans( ['a'..'z', 0..9] => '', :complement ) )
        .comb(5)
        .join: ' ';
}

sub decode (Str $input) is export {
    return $input
            .lc
            .subst( /\W/, '', :g )
            .trans( [ 'a'..'z' ] =>  ['a'..'z'].reverse );
}
