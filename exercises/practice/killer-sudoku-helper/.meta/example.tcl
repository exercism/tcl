proc combinations {sum size exclude} {
    if {$size == 1} {
        if {1 <= $sum && $sum <= 9 && $sum ni $exclude} {
            return $sum
        } else {
            return
        }
    } else {
        set results [dict create]
        for {set n 1} {$n <= 9} {incr n} {
            if {$n ni $exclude} {
                foreach comb [combinations \
                                [expr {$sum - $n}] \
                                [expr {$size - 1}] \
                                [concat $exclude $n]] {
                    dict set results [lsort [concat $comb $n]] 1
                }
            }
        }
        return [dict keys $results]
    }
}
