oo::class create BankAccount {
    variable balance open

    constructor {} {
        set open false
    }

    method open {} {
        if {$open} {
            error "account is already open"
        }
        set balance 0
        set open true
    }

    method AssertOpen {} {
        if {!$open} {
            error "account is not open"
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
            error "invalid amount"
        }
        incr balance $amount
    }

    method withdraw {amount} {
        my AssertOpen
        if {$amount < 0} {
            error "invalid amount"
        }
        if {$amount > $balance} {
            error "insufficient funds"
        }
        incr balance [expr {-1 * $amount}]
    }
}
