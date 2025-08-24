my class X::BankAccount::Closed is Exception {
    method message {'account not open'}
}

my class X::BankAccount::AlreadyOpen is Exception {
    method message {'account already open'}
}

my class X::BankAccount::NotPositive is Exception {
    method message {'amount must be greater than 0'}
}

my class X::BankAccount::NoOverdraft is Exception {
    method message {'amount must be less than balance'}
}

class BankAccount {

    has UInt:D $!balance = 0;
    has Bool:D $.is-open = False;

    method balance {
        X::BankAccount::Closed.new.throw unless $.is-open;
        return $!balance;
    }

    method open {
        X::BankAccount::AlreadyOpen.new.throw if $.is-open;
        return $!is-open.=succ;
    }

    method close {
        self!change-balance(-$.balance);
        return $!is-open.=pred;
    }

    method withdraw (Int:D $amount) {
        X::BankAccount::NotPositive.new.throw if $amount < 0;
        return self!change-balance(-$amount);
    }

    method deposit (Int:D $amount) {
        X::BankAccount::NotPositive.new.throw if $amount < 0;
        return self!change-balance($amount);
    }

    method !change-balance ($amount) {
        X::BankAccount::Closed.new.throw unless $.is-open;
        X::BankAccount::NoOverdraft.new.throw if $amount < 0 && $amount.abs > $.balance;
        return $!balance += $amount;
    }

}
