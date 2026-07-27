oo::class create BankAccount {
    variable balance open

    constructor {} {
        set open false
    }

    method open {} {
        if {$open} {
            error "account already open"
        }
        set balance 0
        set open true
    }

    method AssertOpen {} {
        if {!$open} {
            error "account not open"
        }
    }

    method close {} {
        my AssertOpen
        set open false
    }

    method balance {} {
        my AssertOpen
        return $balance
    }

    method deposit {amount} {
        my AssertOpen
        if {$amount < 0} {
            error "amount must be greater than 0"
        }
        incr balance $amount
    }

    method withdraw {amount} {
        my AssertOpen
        if {$amount < 0} {
            error "amount must be greater than 0"
        }
        if {$amount > $balance} {
            error "amount must be less than balance"
        }
        incr balance [expr {-1 * $amount}]
    }
}
