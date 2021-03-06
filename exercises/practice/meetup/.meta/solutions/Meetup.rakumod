unit module Meetup;

sub meetup-date (Str:D $desc --> Date:D) is export {
  my (Date $date, Str $day-of-week);
  given $desc.words {
    $date = Date.new: year => .[*-1];

    given .[*-2] {
      $date.=later: months => %(<
        January February March
        April May June
        July August September
        October November December
      >.antipairs){$_}
    }

    $day-of-week = S/day// given .[1].lc;
    $date.=later: days => (given .[0] {
      when 'first'   { 0}
      when 'second'  { 7}
      when 'third'   {14}
      when 'fourth'  {21}
      when /teenth$/ {$day-of-week = S/teenth// given $_; 12}
      when 'last'    {$date.=later(:1month); -7}
    });
  }

  $date.=succ until $date.day-of-week == (given <
    mon tues
    wednes thurs
    fri satur sun
  > {
    %(.values Z=> .keys »+» 1){$day-of-week}
  });

  return $date;
}
