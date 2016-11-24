class Leap {
    method is_leap ($year) {
        self.is_divisible($year, 400)
        || self.is_divisible($year, 4)
           && !self.is_divisible($year, 100);
    }

    method is_divisible($year, $number) {
        $year % $number == 0 ?? True !! False;
    }
}
