proc primes {limit} {
    set flags [lrepeat [expr {1 + $limit}] true]

    set removeMultiples {{p limit} {
        upvar 1 flags flags
        if {[lindex $flags $p]} {
            for {set m [expr {$p * $p}]} {$m <= $limit} {incr m $p} {
                lset flags $m false
            }
        }
    }}

    for {set prime 2} {$prime <= int(sqrt($limit))} {incr prime} {
        apply $removeMultiples $prime $limit
    }

    set primes [list]
    for {set i 2} {$i <= $limit} {incr i} {
        if {[lindex $flags $i]} {
            lappend primes $i
        }
    }
    return $primes
}
