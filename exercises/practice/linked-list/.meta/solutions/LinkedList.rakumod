unit class LinkedList;

class Node {
    has Node ( $.head, $.tail ) is rw;
    has $.value;
}

has Node $.head-node is rw;

method push ($value) {
    if !$.head-node {
        $!head-node.=new( :$value )
    }
    else {
        my Node $current-node = $!head-node;
        while $current-node.tail {
            $current-node.=tail;
        }
        $current-node.tail.=new( :head($current-node) :$value );
    }
}

method pop {
    my Node $current-node = $!head-node;
    while $current-node.tail {
        $current-node.=tail;
    }
    if $current-node.head {
        $current-node.head.tail = Nil;
    }
    else {
        $!head-node = Nil;
    }
    return $current-node.value;
}

method shift {
    my $value = $.head-node.value;
    $!head-node.=tail;
    if $.head-node {
        $.head-node.head = Nil;
    }
    return $value;
}

method unshift ($value) {
    if !$.head-node {
        $!head-node.=new( :$value );
    }
    else {
        $.head-node.head.=new( :tail($.head-node), :$value );
        $!head-node.=head;
    }
}

method count {
    my Int $i = 0;
    if $.head-node {
        $i++;
        my Node $current-node = $.head-node;
        while $current-node.tail {
            $current-node.=tail;
            $i++;
        }
    }

    return $i;
}

method delete ($value) {
    if $.head-node.value == $value {
        self.shift;
        return;
    }
    my Node $current-node = $.head-node;
    until $current-node.value == $value {
        if $current-node {
            $current-node.=tail;
        }
        if !$current-node {
            return;
        }
    }
    if $current-node.head {
        $current-node.head.tail = $current-node.tail;
    }
    if $current-node.tail {
        $current-node.tail.head = $current-node.head;
    }
}
