proc jigsawData {input} {
    set possible {}

    if {[dict exists $input pieces]} {
        set pieces [dict get $input pieces]
        for {set cols 1} {$cols <= $pieces} {incr cols} {
            if {$pieces % $cols == 0} {
                set rows [expr {$pieces / $cols}]
                if {[matchesInput $rows $cols $input]} {
                    lappend possible [list $rows $cols]
                }
            }
        }
    } elseif {[dict exists $input inside]} {
        set inside [dict get $input inside]
        for {set innerCols 1} {$innerCols <= $inside} {incr innerCols} {
            if {$inside % $innerCols == 0} {
                set innerRows [expr {$inside / $innerCols}]
                set cols [expr {$innerCols + 2}]
                set rows [expr {$innerRows + 2}]
                if {[matchesInput $rows $cols $input]} {
                    lappend possible [list $rows $cols]
                }
            }
        }
    } else {
        set border [dict getdef $input border -1]
        set maxSide [expr {$border == -1 ? 1000 : $border}]
        for {set rows 1} {$rows <= $maxSide} {incr rows} {
            for {set cols 1} {$cols <= $maxSide} {incr cols} {
                if {[matchesInput $rows $cols $input]} {
                    lappend possible [list $rows $cols]
                }
            }
        }
    }

    switch -- [llength $possible] {
        1 {
            lassign [lindex $possible 0] rows cols
            return [fromRowsAndCols $rows $cols]
        } 
        0 { error "Contradictory data" }
        default { error "Insufficient data" }
    }
}

proc matchesInput {rows columns input} {
    set jigsaw [fromRowsAndCols $rows $columns]
    foreach item {rows columns pieces border inside aspectRatio format} {
        if {[dict exists $input $item]} {
            if {[dict get $input $item] != [dict get $jigsaw $item]} {
                return false
            }
        }
    }
    return true
}

proc fromRowsAndCols {rows columns} {
    set pieces [expr {$rows * $columns}]
    set border [expr {2 * ($columns + $rows - 2)}]
    set aspect [expr {1.0 * $columns / $rows}]

    return [list \
        pieces $pieces \
        border $border \
        inside [expr {$pieces - $border}] \
        rows $rows \
        columns $columns \
        aspectRatio $aspect \
        format [expr {$aspect == 1 ? "square" : ($aspect < 1 ? "portrait" : "landscape")}] \
    ]
}
