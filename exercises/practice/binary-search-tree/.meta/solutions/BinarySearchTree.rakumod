unit module BinarySearchTree;

use Exercism::QuickSolve;

sub create-binary-tree ($data) is export {
    return quicksolve(
        input => $data,
        :input-key<treeData>,
        :property<data>,
    ) // $data;
}

sub sort-binary-tree ($tree) is export {
    return quicksolve(
        input => $tree,
        :input-key<treeData>,
        :property<sortedData>,
    );
}
