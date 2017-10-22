# Leap

Given a year, report if it is a leap year.

The tricky thing here is that a leap year in the Gregorian calendar occurs:

```text
on every year that is evenly divisible by 4
  except every year that is evenly divisible by 100
    unless the year is also evenly divisible by 400
```

For example, 1997 is not a leap year, but 1996 is.  1900 is not a leap
year, but 2000 is.

If your language provides a method in the standard library that does
this look-up, pretend it doesn't exist and implement it yourself.

## Notes

Though our exercise adopts some very simple rules, there is more to
learn!

For a delightful, four minute explanation of the whole leap year
phenomenon, go watch [this youtube video][video].

[video]: http://www.youtube.com/watch?v=xX96xng7sAE

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

JavaRanch Cattle Drive, exercise 3 [http://www.javaranch.com/leap.jsp](http://www.javaranch.com/leap.jsp)

## Submitting Incomplete Solutions
It's possible to submit an incomplete solution so you can see how others have completed the exercise.
