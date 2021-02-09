proc sumOfMultiples {factors limit} {
    set numbers {}
    set sum 0
    foreach f $factors {
        if {$f == 0} then continue
        set n $f
        while {$n < $limit} {
            if {![dict exists $numbers $n]} {
                incr sum $n
                dict set numbers $n 1
            }
            incr n $f
        }
    }
    return $sum
}
