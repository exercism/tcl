proc triangle {n} {
    set rows {}
    for {set i 1} {$i <= $n} {incr i} {
        set row {}
        for {set j 1} {$j <= $i} {incr j} {
            lappend row [expr {binomialCoefficient($i-1, $j-1)}]
        }
        lappend rows $row
    }
    return $rows
}


proc ::tcl::mathfunc::binomialCoefficient {n k} {
    return [expr {factorial($n) / (factorial($k) * factorial($n -$k))}]
}

proc ::tcl::mathfunc::factorial {n {accum 1}} {
    if {$n < 2} {
        return $accum
    }
    set procname [lindex [info level 0] 0]
    tailcall $procname [expr {$n - 1}] [expr {$accum * $n}]
}
