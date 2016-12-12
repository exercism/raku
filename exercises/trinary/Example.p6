sub to-decimal($num) is export {

    return 0 if $num ~~ /<-[012]>/;

    return reduce { 3 * $^a + $^b }, 0, |$num.comb;
}
