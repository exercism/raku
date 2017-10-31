# Meetup

Calculate the date of meetups.

Typically meetups happen on the same day of the week.  In this exercise, you will take
a description of a meetup date, and return the actual meetup date.

Examples of general descriptions are:

- the first Monday of January 2017
- the third Tuesday of January 2017
- the Wednesteenth of January 2017
- the last Thursday of January 2017

Note that "Monteenth", "Tuesteenth", etc are all made up words. There
was a meetup whose members realized that there are exactly 7 numbered days in a month that
end in '-teenth'. Therefore, one is guaranteed that each day of the week
(Monday, Tuesday, ...) will have exactly one date that is named with '-teenth'
in every month.

Given examples of a meetup dates, each containing a month, day, year, and descriptor
(first, second, teenth, etc), calculate the date of the actual meetup.
For example, if given "First Monday of January 2017", the correct meetup date is 2017/1/2

## Resources

Remember to check out the Perl 6 [documentation](https://docs.perl6.org/) and
[resources](https://perl6.org/resources/) pages for information, tips, and
examples if you get stuck.

## Running the tests

There is a test suite and module included with the exercise.
The test suite (a file with the extension `.t`) will attempt to run routines
from the module (a file with the extension `.pm6`).
Add/modify routines in the module so that the tests will pass! You can view the
test data by executing the command `perl6 --doc *.t` (\* being the name of the
test suite), and run the test suite for the exercise by executing the command
`prove . --exec=perl6` in the exercise directory.
You can also add the `-v` flag e.g. `prove . --exec=perl6 -v` to display all
tests, including any optional tests marked as 'TODO'.

## Source

Jeremy Hinegardner mentioned a Boulder meetup that happens on the Wednesteenth of every month [https://twitter.com/copiousfreetime](https://twitter.com/copiousfreetime)

## Submitting Incomplete Solutions
It's possible to submit an incomplete solution so you can see how others have completed the exercise.
