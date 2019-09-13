proc saddlePoints {matrix} {
    # no saddle points in empty matrices
    if {[llength $matrix] == 0 || [llength [lindex $matrix 0]] == 0} {
        return {}
    }

    set rowMax [lmap row $matrix {::tcl::mathfunc::max {*}$row}]

    set numCols [llength [lindex $matrix 0]]
    set colMin {}
    for {set i 0} {$i < $numCols} {incr i} {
        set col [lmap row $matrix {lindex $row $i}]
        lappend colMin [::tcl::mathfunc::min {*}$col]
    }

    set saddlePoints {}
    for {set row 0} {$row < [llength $matrix]} {incr row} {
        for {set col 0} {$col < [llength [lindex $matrix 0]]} {incr col} {
            set val [lindex $matrix $row $col]
            if {$val == [lindex $rowMax $row] && $val == [lindex $colMin $col]} {
                set x [expr {$row + 1}]
                set y [expr {$col + 1}]
                lappend saddlePoints [list $x $y]
            }
        }
    }

    return $saddlePoints
}
