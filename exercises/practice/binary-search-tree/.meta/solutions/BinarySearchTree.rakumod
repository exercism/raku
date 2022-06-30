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
        $!root.&(sub ($node) {
            if $data > $node.data {
                with $node.right {
                    .&?ROUTINE;
                }
                else {
                    $node.right.=new(:$data);
                }
            }
            orwith $node.left {
                .&?ROUTINE;
            }
            else {
                $node.left.=new(:$data);
            }
        });
    }

    return self;
}

method sort {
    return [];
}
