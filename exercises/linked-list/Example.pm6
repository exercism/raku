class ListNode {
    has $.next     is rw;
    has $.previous is rw;
    has $.value;
}

class LinkedList is export {
    has $!first;
    has $!last;

    method push($value) {
        my $next = ListNode.new( value => $value, previous => $!last );
        if ( $!last ) {
            $!last = $!last.next= $next ;
        }
        else {
            $!first = $!last = $next;
        }
    }

    method unshift($value) {
        my $next = ListNode.new( value => $value, next => $!first );
        if ( $!first ) {
            $!first = $!first.previous = $next ;
        }
        else {
            $!first = $!last = $next;
        }
    }

    method shift() {
        my $f = $!first;

        $!first = $!first.next;

        unless $!first  { $!last = $!first }

        return $f.value;
    }

    method pop() {
        my $f = $!last;

        $!last = $!last.previous;

        unless $!.last  { $!first = $!last }

        return $f.value;
    }
};

