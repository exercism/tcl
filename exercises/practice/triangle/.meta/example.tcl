namespace eval triangle {
    proc is {type sides} {
        set uniqSides [lsort -real -unique $sides]
        set num [llength $uniqSides]

        if {[lindex $uniqSides 0] <= 0} {
            # a triangle cannot have a side of zero or negative length
            return false
        }

        switch -exact -- $type {
            equilateral {
                return [expr {$num == 1}]
            }
            isosceles {
                switch -exact -- $num {
                    1 {return true}
                    2 {
                        lassign $uniqSides a b
                        return [expr {2*$a > $b}]
                    }
                    default {return false}
                }
            }
            scalene {
                lassign $uniqSides a b c
                return [expr {$num == 3 && $a + $b > $c}]
            }
            default {error "invalid triangle type $type"}
        }
    }
}
