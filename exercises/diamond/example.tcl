proc diamond {letter} {
    set A [scan "A" %c]     ;# ASCII value of character 'A'
    set size [expr {[scan $letter %c] - $A + 1}]

    # top-right quadrant
    set quadrant {}
    set spaces [string repeat " " $size]
    for {set i 0} {$i < $size} {incr i} {
        set char [format %c [expr {$A + $i}]]
        lappend quadrant [string replace $spaces $i $i $char]
    }

    # top half
    set half [lmap right $quadrant {
        set left [string reverse [string range $right 1 end]]
        string cat $left $right
    }]

    # full diamond
    set diamond [concat $half [lreverse [lrange $half 0 end-1]]]
    return [join $diamond \n]
}

