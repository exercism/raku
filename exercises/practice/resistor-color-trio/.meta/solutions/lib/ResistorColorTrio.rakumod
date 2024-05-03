unit module ResistorColorTrio;

sub units ( $Ω ) {
  given elems gather for $Ω.flip.comb { last if $_ ne 0; .take } {
    when    9    { $Ω.substr( 0, *-9 ) ~ ' gigaohms' }
    when    6..8 { $Ω.substr( 0, *-6 ) ~ ' megaohms' }
    when    3..5 { $Ω.substr( 0, *-3 ) ~ ' kiloohms' }
    default      { $Ω                  ~ ' ohms'     }
  }
}

sub create-label ( *@colors ) is export {
  given <black brown red orange yellow green blue violet grey white>.antipairs.Hash{ @colors[ ^ 3 ] } {
    units Int.new: [~] .[ ^ 2 ].Slip, 0 x .[ 2 ]
  }
}
