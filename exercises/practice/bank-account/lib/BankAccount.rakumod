my class X::BankAccount::Closed is Exception {
    method message {'account not open'}
}

my class X::BankAccount::AlreadyOpen is Exception {
    method message {'account already open'}
}

my class X::BankAccount::AmountNotPositive is Exception {
    method message {'amount must be greater than 0'}
}

my class X::BankAccount::NoOverdraft is Exception {
    method message {'amount must be less than balance'}
}

class BankAccount {
    has $.balance;

    method open {
    }

    method close {
    }

    method withdraw ($amount) {
    }

    method deposit ($amount) {
    }
}
