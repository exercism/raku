class Grains {

    method square($number) {
        2**($number-1);
    }

    method total {
        my $total;
        for  1..64 { $total += self.square($_) }
        $total;
    }
}
