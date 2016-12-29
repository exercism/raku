class Robot is export {
    has $.name is rw = self.reset_name;

    method rand_letter {
        ['A'..'Z'].pick;
    }

    method rand_suffix {
        100 + 900.rand.truncate;
    }

    method new_name {
        self.rand_letter ~ self.rand_letter ~ self.rand_suffix;
    }

    method reset_name {
        self.name = self.new_name;
    }
}
