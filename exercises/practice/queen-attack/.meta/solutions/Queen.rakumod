unit class Queen;

subset Position of Int where ^8;
has Position ( $.row, $.column );

method can-attack ( Queen:D \other --> Bool:D ) {
    return
         self.row    == other.row
      || self.column == other.column
      || abs(self.row - other.row) == abs(self.column - other.column);
}
