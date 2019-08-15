#! tclsh

proc slices {series length} {
    if {$series eq ""} {
        error "series cannot be empty"
    }

    set serieslen [string length $series]
    if {$length > $serieslen} {
        error "slice length cannot be greater than series length"
    }
    if {$length <= 0} {
        error "slice length cannot be less than one"
    }

    set delta [expr {$length - 1}]
    for {set i 0} {$i <= $serieslen - $length} {incr i} {
        lappend result [string range $series $i $i+$delta]
    }
    return $result
}

