unit class BinarySearchTree;

class Node {
    has $.data;
    has Node ($.left, $.right) is rw;
}

has Node $.root;

method add ($data) {
    if !$!root {
        $!root.=new(:$data);
    }
    else {
    }

    return self;
}

method sort {
    return [];
}
