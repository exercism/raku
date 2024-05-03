unit class BinarySearchTree;

class Node {
    has $.data;
    has Node ($.left, $.right) is rw;

    method set ($data) {
        if $data > self.data {
            with self.right {
                .set($data);
            }
            else {
                self.right.=new(:$data);
            }
        }
        orwith self.left {
            .set($data);
        }
        else {
            self.left.=new(:$data);
        }
    }
}

has Node $.root is rw;

method add ($data) {
    $!root.set($data);
}

method sort (--> List()) {
    return gather {
        $!root.&(sub ($node) {
            with $node.left {
                .&?ROUTINE;
            }

            take $node.data;

            with $node.right {
                .&?ROUTINE;
            }
        });
    };
}
