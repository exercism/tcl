namespace import ::tcl::mathop::+
namespace import ::tcl::mathop::-

############################################################
oo::class create GoBoard {
    variable board
    variable width
    variable height

    constructor {input} {
        set board [lmap row $input {split $row ""}]
        set height [llength $board]
        set width [llength [lindex $board 0]]
    }

    method at {intersection} {
        lindex $board {*}[lreverse $intersection]
    }

    method territories {} {
        set visited [Set new]
        set territories [dict create black {} white {} none {}]

        for {set x 0} {$x < $width} {incr x} {
            for {set y 0} {$y < $height} {incr y} {
                set intersection [list $x $y]
                if {![$visited contains $intersection]} {
                    lassign [my territory $intersection] owner territory
                    foreach intersection $territory {
                        $visited add $intersection
                        dict lappend territories $owner $intersection
                    }
                }
            }
        }

        return $territories
    }

    method territory {intersection} {
        my validate $intersection

        # a stone is not in any territory
        if {[my at $intersection] ne " "} {
            return {none {}}
        }

        set owner ""
        set territory [Set new]
        set visited [Set new]
        set tovisit [[Queue new] add $intersection]

        while {![$tovisit isEmpty]} {
            set current [$tovisit remove]
            set cell [my at $current]
            switch -exact -- $cell {
                " " {
                    $visited add $current
                    $territory add $current
                    foreach adjacent [my adjacentIntersections $current] {
                        if {
                            ![$visited contains $adjacent] && 
                            ![$tovisit contains $adjacent]
                        } {
                            $tovisit add $adjacent
                        }
                    }
                }
                "B" - "W" {
                    if {$owner eq ""} {
                        set owner $cell
                    } elseif {$owner ne "none" && $cell ne $owner} {
                        # this territory abuts both B and W stones
                        set owner none
                    }
                }
            }
        }

        return [list [my ownerName $owner] [lsort [$territory elements]]]
    }

    method validate {intersection} {
        lassign $intersection x y
        if {$x < 0 || $x >= $width || $y < 0 || $y >= $height} {
            error "Invalid coordinate"
        }
    }

    method ownerName {owner} {
        switch -- $owner {
            "B"     {return black}
            "W"     {return white}
            default {return none}
        }
    }

    method adjacentIntersections {intersection} {
        lassign $intersection x y
        set adjacent {}
        if {$x > 0} {
            lappend adjacent [list [- $x 1] $y]
        }
        if {$x < $width - 1 } {
            lappend adjacent [list [+ $x 1] $y]
        }
        if {$y > 0} {
            lappend adjacent [list $x [- $y 1]]
        }
        if {$y < $height - 1 } {
            lappend adjacent [list $x [+ $y 1]]
        }
        return $adjacent
    }
}

############################################################
oo::class create Queue {
    variable data

    constructor {} {
        set data [list]
    }

    # add to tail of queue
    method add {element} {
        lappend data $element
        return [self]
    }

    # remove from head of queue
    method remove {} {
        # using the performance hack at "Unsharing Objects"
        # in https://wiki.tcl-lang.org/K
        set data [lassign $data[set data {}] element]
        return $element
    }

    method contains {element} {
        return [expr {$element in $data}]
    }

    method isEmpty {} {
        return [expr {[llength $data] == 0}]
    }
}

############################################################
oo::class create Set {
    variable data

    constructor {} {
        set data [dict create]
    }
    
    method add {element} {
        dict set data $element ""
        return [self]
    }

    method remove {element} {
        dict unset data $element
        return [self]
    }

    method contains {element} {
        return [dict exists $data $element]
    }

    method elements {} {
        return [dict keys $data]
    }
}
