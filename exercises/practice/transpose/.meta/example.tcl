proc transpose {lines} {
    if {[llength $lines] == 0} {
        return {}
    }

    set transposed {}
    set maxW [::tcl::mathfunc::max {*}[lmap line $lines {string length $line}]]
    for {set i 0} {$i < $maxW} {incr i} {
        set column [lmap line $lines {
            set char [string range $line $i $i]
            expr {$char eq "" ? " " : $char}
        }]
        lappend transposed [join $column ""]
    }

    # trim trailing whitespace from the last line
    lset transposed end [string trimright [lindex $transposed end]]

    # then each preceding line must have equal or greater length
    for {set i [expr {[llength $transposed] - 2}]} {$i >= 0} {incr i -1} {
        set wid [string length [lindex $transposed $i+1]]
        set text [string trimright [lindex $transposed $i]]
        lset transposed $i [format {%-*s} $wid $text]
    }
    return $transposed
}
