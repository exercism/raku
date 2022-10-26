unit module BinarySearch;

multi binary-search (:@array, :$value --> Int) is export {
    binary-search(@array, $value, 0, @array.end);
}

multi binary-search(@array, $value, $low, $high where { $low <= $high }) {
    my Int() $mid = ($low + $high) / 2;
    given @array[ $mid ] {
        when * < $value {
            binary-search(@array, $value, $mid + 1, $high);
        }
        when * > $value {
            binary-search(@array, $value, $low, $mid - 1);
        }
        default {
            $mid
        }
    }
}
