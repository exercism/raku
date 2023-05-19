sub handshake ( $number ) is export {
    my @result;
    push @result, 'wink'            if 0b00001 +& $number;
    push @result, 'double blink'    if 0b00010 +& $number;
    push @result, 'close your eyes' if 0b00100 +& $number;
    push @result, 'jump'            if 0b01000 +& $number;
    @result = reverse @result       if 0b10000 +& $number;
    return @result;
}
