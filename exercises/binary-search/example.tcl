proc binarySearch {haystack needle} {
    set left 0
    set right [expr {[llength $haystack] - 1}]

    while {$left <= $right} {
        set mid [expr {($left + $right) / 2}]
        set elem [lindex $haystack $mid]
        if {$elem < $needle} {
            set left [expr {$mid + 1}]
        } elseif {$elem > $needle} {
            set right [expr {$mid - 1}]
        } else {
            return $mid
        }
    }

    # not found
    return -1
}
