proc recite {items} {
    set len [llength $items]
    set lines {}
    for {set i 1} {$i < $len} {incr i} {
        lassign [lrange $items $i-1 $i] this that
        lappend lines "For want of a $this the $that was lost." 
    }
    if {$len > 0} {
        lappend lines "And all for the want of a [lindex $items 0]."
    }
    return $lines
}
