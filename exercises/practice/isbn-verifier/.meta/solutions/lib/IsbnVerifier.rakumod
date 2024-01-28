unit module IsbnVerifier;

sub is-isbn10 ($number) is export {
  my @sift = gather for $number.comb {
         when                 '-' {       }
         when / <:Number> / | 'X' { .take }
      default                     { return False }
  };

  return False unless @sift.elems == 10;
  @sift.tail = 10 if @sift.tail eq 'X';
  return False unless @sift.all.contains: any ^10;

  return sum( @sift Z× (10...1) ) %% 11
}
