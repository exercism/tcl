proc factors {n} {
    set factors {}
    for {set p 2} {$p ** 2 <= $n} {incr p} {
        while {$n % $p == 0} {
            lappend factors $p
            set n [expr {$n / $p}]
        }
    }
    if {$n > 1} {
        lappend factors $n
    }
    return $factors
}
