class Accumulate is export {
    method accumulate (@list, $function){
        my @accumulated;
        for @list -> $element {
            @accumulated.push: $function($element);
        }
        return @accumulated;
    }
}
