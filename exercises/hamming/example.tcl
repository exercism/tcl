proc hammingDistance {left right} {
    if {$left eq "" && $right ne ""} {
        error "left strand must not be empty"
    }
    if {$left ne "" && $right eq ""} {
        error "right strand must not be empty"
    }
    if {[string length $left] != [string length $right]} {
        error "left and right strands must be of equal length"
    }

    set dist 0
    for {set i 0} {$i < [string length $left]} {incr i} {
        if {[string range $left $i $i] ne [string range $right $i $i]} {
            incr dist
        }
    }
    return $dist
}
