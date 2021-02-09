namespace eval Change {
    namespace export findMinimumCoins

    proc findMinimumCoins {amount coins} {
        if {$amount < 0} {
            error "target can't be negative"
        }

        lassign [change $amount $coins] C S

        return [makeChange $amount $coins $S]
    }

    # Change making algorithm from
    # http://www.ccs.neu.edu/home/jaa/CSG713.04F/Information/Handouts/dyn_prog.pdf
    #
    # This function generates two lists:
    #
    # C = the minimum _number of coins_ required to make change
    #     for each n from 1 to amount. It is returned but only
    #     used internally in this application.
    #
    # S = the _first_ coin used to make change for amount n.
    #     "-1" is a placeholder for "can't make change"

    proc change {amount coins} {
        set MAX Inf
        set C [concat 0 [lrepeat $amount $MAX]]
        set S [concat 0 [lrepeat $amount -1]]

        for {set p 1} {$p <= $amount} {incr p} {
            set min $MAX
            set currentCoin -1
            foreach coin $coins {
                if {$coin <= $p} {
                    set currentNumCoins [lindex $C $p-$coin]
                    if {1 + $currentNumCoins < $min} {
                        set min [expr {1 + $currentNumCoins}]
                        set currentCoin $coin
                    }
                }
            }
            lset C $p $min
            lset S $p $currentCoin
        }
        return [list $C $S]
    }

    proc makeChange {amount coins S} {
        set change [list]
        if {[lindex $S $amount] == -1} {
            error "can't make target with given coins"
        }
        while {$amount > 0} {
            set coin [lindex $S $amount]
            lappend change $coin
            incr amount "-$coin"
        }
        return [lsort -integer $change]
    }
}

namespace import Change::findMinimumCoins
