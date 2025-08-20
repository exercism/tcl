proc degreeOfSeparation {personA personB familyTree} {
    set neighbours [neighbours $familyTree]

    if {![dict exists $neighbours $personA] || ![dict exists $neighbours $personB]} {
        return -1
    }

    set queue [list [list $personA 0]]
    set visited [dict create $personA true]

    while {[llength $queue] > 0} {
        lassign [lindex $queue 0] current degree

        if {$current eq $personB} {
            return $degree
        }

        set queue [lrange $queue 1 end]
        incr degree

        foreach neighbour [dict get $neighbours $current] {
            if {![dict getdef $visited $neighbour false]} {
                lappend queue [list $neighbour $degree]
                dict set visited $neighbour true
            }
        }
    }

    return -1
}

proc neighbours {familyTree} {
    set neighbours [dict create]
    dict for {parent children} $familyTree {
        if {![dict exists $neighbours $parent]} {
            dict set neighbours $parent [list]
        }
        foreach child $children {
            if {![dict exists $neighbours $child]} {
                dict set neighbours $child [list]
            }
            if {[lsearch -exact [dict get $neighbours $parent] $child] == -1} {
                dict lappend neighbours $parent $child
            }
            if {[lsearch -exact [dict get $neighbours $child] $parent] == -1} {
                dict lappend neighbours $child $parent
            }
        }

        if {[llength $children] > 1} {
            foreach child1 $children {
                foreach child2 $children {
                    if {$child1 ne $child2} {
                        if {[lsearch -exact [dict get $neighbours $child1] $child2] == -1} {
                            dict lappend neighbours $child1 $child2
                        }
                    }
                }
            }
        }
    }
    return $neighbours
}
