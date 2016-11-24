class Raindrops {
    method convert ($num) {
       my $str = '';
       $str ~= "Pling" if $num % 3 == 0;
       $str ~= "Plang" if $num % 5 == 0;
       $str ~= "Plong" if $num % 7 == 0;
       return $str ?? $str !! $num;
    }
}
