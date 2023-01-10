proc combinations {sum size exclude} {
    set procname [lindex [info level 0] 0]
    if {$size == 1} {
        if {1 <= $sum && $sum <= 9 && $sum ni $exclude} {
            return $sum
        }
    } else {
        set results [dict create]
        for {set n 1} {$n <= 9} {incr n} {
            if {$n ni $exclude} {
                foreach comb [$procname \
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
