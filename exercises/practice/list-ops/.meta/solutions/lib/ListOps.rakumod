unit module ListOps;

multi concatenate-lists (@list1, @list2) is export {
    return @list1, @list2;
}

multi concatenate-lists (@lists) is export {
    return |@lists;
}
