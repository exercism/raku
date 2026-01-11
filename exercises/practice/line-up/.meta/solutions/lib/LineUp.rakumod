unit module LineUp;

sub deli-order (:$customer, :$ticket) is export {
  sub ordinal ($num) {
    return .value with first { $ticket.ends-with: .key }, ( <11 12 13 1 2 3> Z=> <th th th st nd rd> );
    return 'th'
  }
  sprintf
    '%s, you are the %d%s customer we serve today. Thank you!',
    $customer, $ticket, ordinal $ticket
}
