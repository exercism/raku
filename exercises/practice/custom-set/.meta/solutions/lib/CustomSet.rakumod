unit class CustomSet;

has Set $.elements;
method is-empty {
  self.elements eqv ∅
}
method contains ($element) {
  $element ∈ self.elements
}
method has-subset ($set) {
  self.elements ⊆ $set
}
method is-disjoint ($set) {
  self.intersection($set) eqv ∅
}
method is-equal ($set) {
  self.elements ≡ $set
}
method add ($set) {
  $!elements ∪= $set
}
method intersection ($set) {
  $!elements ∩= $set
}
method difference ($set) {
  self.elements ∖ $set
}
method complement ($set) {
  self.difference($set)
}
method union ($set) {
  self.add($set)
}
