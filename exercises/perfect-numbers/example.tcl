namespace eval perfectNumbers {
    namespace export classify

    proc classify {n} {
        if {$n <= 0} {
            error "Classification is only possible for natural numbers."
        }
        set a [aliquotSum $n]
        if {$a < $n} then { return "deficient" } 
        if {$a > $n} then { return "abundant" }
        return "perfect"
    }

    proc aliquotSum {number} {
        if {$number == 1} {
            set sum 0
        } else {
            set sum 1
            for {set i 2} {$i <= isqrt($number)} {incr i} {
                if {$number % $i == 0} {
                    set quo [expr {$number / $i}]
                    incr sum $i
                    # for squares, only add the factor once
                    if {$i != $quo} then {incr sum $quo}
                }
            }
        }
        return $sum
    }
}

namespace import perfectNumbers::*
