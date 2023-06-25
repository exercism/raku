unit module Matrix;

sub extract-row(:$string, :$index) is export {
  $string.lines[$index.pred].words
}

sub extract-column(:$string, :$index) is export {
  gather for $string.lines { take .words[$index.pred] }
}
