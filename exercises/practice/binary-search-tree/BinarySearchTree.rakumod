unit class BinarySearchTree;

class Node {
    has $.data;
    has Node ($.left, $.right) is rw;
}

has Node $.root;

method add ($data) {
    when !$!root {
        $!root.=new(:$data);
    }

    # Set left/right nodes here
}

method sort (--> Iterable) {
    return [];
}
