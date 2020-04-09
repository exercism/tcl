namespace eval connect {
    namespace export winner

    proc winner {board} {
        set matrix [lmap row $board {split [string trim $row]}]

        set winner ""
        if {[checkWinner $matrix O]} {
            set winner O
        } elseif {[checkWinner [transpose $matrix] X]} {
            set winner X
        }

        return $winner
    }

    proc transpose {matrix} {
        set transposed {}
        set width [llength [lindex $matrix 0]]
        for {set i 0} {$i < $width} {incr i} {
            lappend transposed [lmap row $matrix {lindex $row $i}]
        }
        return $transposed
    }

    proc checkWinner {matrix player} {
        # assume square
        set width [llength $matrix]

        set stack {}

        # my pieces in the top row
        for {set c 0} {$c < $width} {incr c} {
            if {[lindex $matrix 0 $c] eq $player} {
                lappend stack [list 0 $c]
            }
        }
        if {[llength $stack] == 0} {
            return false
        }
        if {$width == 1} {
            return true
        }

        while {[llength $stack] > 0} {
            lassign [lindex $stack end] r c
            set stack [lrange $stack 0 end-1]
            foreach pos [myNeighbours $matrix $player $r $c] {
                lassign $pos rr cc
                if {$rr == $width - 1} {
                    # I have a neighbour in the last row
                    return true
                }
                lset matrix $r $c "seen"  ;# no backtracking
                lappend stack [list $rr $cc]
            }
        }

        return false
    }

    proc myNeighbours {matrix player r c} {
        set width [llength $matrix]
        set neighbours {}
        foreach dr {-1 0 1} {
            foreach dc {-1 0 1} {
                if {$dr == $dc} then continue
                set rr [expr {$r + $dr}]
                set cc [expr {$c + $dc}]
                if {0 <= $rr && $rr < $width &&
                    0 <= $cc && $cc < $width &&
                    [lindex $matrix $rr $cc] eq $player
                } {
                    lappend neighbours [list $rr $cc]
                }
            }
        }
        return $neighbours
    }
}

namespace import connect::winner
