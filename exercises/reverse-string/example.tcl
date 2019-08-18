proc stringReverse {str} {
    set rev ""
    for {set i [expr {[string length $str] - 1}]} {$i >= 0} {incr i -1} {
        append rev [string range $str $i $i]
    }
    return $rev
}
