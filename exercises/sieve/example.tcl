proc primes {limit} {
    # mark all candidates as prime
    set flags [lrepeat [expr {1 + $limit}] true]

    # mark multiples of candidates as not prime
    for {set p 2} {$p <= sqrt($limit)} {incr p} {
        if {[lindex $flags $p]} {
            set step [expr {$p == 2 ? 2 : $p * 2}]
            for {set m [expr {$p * $p}]} {$m <= $limit} {incr m $step} {
                lset flags $m false
            }
        }
    }

    # extract the remaining candidates
    set primes [list]
    for {set i 2} {$i <= $limit} {incr i} {
        if {[lindex $flags $i]} {
            lappend primes $i
        }
    }
    return $primes
}
