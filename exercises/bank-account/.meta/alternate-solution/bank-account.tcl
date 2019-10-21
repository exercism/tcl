package require Thread

namespace eval account {
    namespace export create open close balance deposit withdraw
    namespace ensemble create

    variable id 0

    proc create {} {
        variable id
        set accountId "[namespace current]::[incr id]"
        tsv::set $accountId Open false 
        return $accountId
    }

    proc open {acctId} {
        tsv::lock $acctId {
            if {[tsv::get $acctId Open]} {
                error "account is already open"
            }
            tsv::set $acctId Balance 0
            tsv::set $acctId Open true
        }
    }

    proc assertOpen {acctId} {
        if {![tsv::get $acctId Open]} {
            error "account is not open"
        }
    }

    proc close {acctId} {
        tsv::lock $acctId {
            assertOpen $acctId
            tsv::set $acctId Open false
        }
    }

    proc balance {acctId} {
        tsv::lock $acctId {
            assertOpen $acctId
            return [tsv::get $acctId Balance]
        }
    }

    proc deposit {acctId amount} {
        tsv::lock $acctId {
            assertOpen $acctId
            if {$amount < 0} {
                error "invalid amount"
            }
            tsv::incr $acctId Balance $amount
        }
    }

    proc withdraw {acctId amount} {
        tsv::lock $acctId {
            assertOpen $acctId
            if {$amount < 0} {
                error "invalid amount"
            }
            if {$amount > [tsv::get $acctId Balance]} {
                error "insufficient funds"
            }
            tsv::incr $acctId Balance [expr {-1 * $amount}]
        }
    }
}
