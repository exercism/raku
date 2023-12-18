unit class BinarySearchTree;

class Node {
    has $.data;
    has Node ($.left, $.right) is rw;
}

has Node $.root is rw;

method add ($data) {
    # $.root contains the initial node.
}

method sort (--> List()) {
    return ();
}
