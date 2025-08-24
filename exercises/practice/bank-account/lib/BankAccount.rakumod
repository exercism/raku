my class X::BankAccount::Closed is Exception {
    method message {'account not open'}
}

class BankAccount {

    has UInt:D $.balance = 0;

    method open {
        return True;
    }

    method close {
        return True;
    }

    method withdraw (Int:D $amount where * > 0) {
    }

    method deposit (Int:D $amount where * > 0) {
    }

    method !change-balance ($amount) {
    }
}
