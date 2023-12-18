unit module RomanNumerals;

enum Roman (
  'I', |( gather {
    for ｢IVXLCDM｣.comb.rotor(3 => -1) -> @group {
      for 1, 2 {
        take @group[0, $_].join;
        take @group[$_];
      }
    }
  } ) Z=> ( 1, |( * X* 4, 5, 9, 10 ) … ∞ )
);

sub to-roman ($number) is export {
  [~] gather {
    for $number.flip.comb.pairs.reverse {
      given 10 ** .key -> $pv {
        when .value == 4 | 9 {
          take Roman( $pv * .value );
        }
        take Roman( $pv * 5 ) if .value ≥ 5;
        take Roman( $pv ) x .value % 5;
      }
    }
  };
}
