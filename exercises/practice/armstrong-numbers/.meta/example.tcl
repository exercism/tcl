proc isArmstrongNumber {number} {
    # [string is] - https://www.tcl-lang.org/man/tcl8.6/TclCmd/string.htm#M10
    if {![string is entier -strict $number]} {
        error "not a number"
    }
    set sum 0
    if {$number > 0} {
        set n $number

        # [string length], mathematically
        set len [expr {int(ceil(log10($number)))}]

        while {$n > 0} {
            lassign [divmod $n 10] n digit
            incr sum [expr {$digit ** $len}]
        }
    }
    return [expr {$sum == $number}]
}

proc divmod {n d} {
    return [list [expr {$n / $d}] [expr {$n % $d}]]
}
