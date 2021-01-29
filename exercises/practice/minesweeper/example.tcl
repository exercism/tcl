namespace eval MineField {
    namespace export annotate

    proc annotate {minefield} {
        if {[llength $minefield] == 0} {
            return {}
        }
        if {[string length [lindex $minefield 0]] == 0} {
            return {""}
        }

        set annotated [lmap row $minefield {split $row ""}]

        for {set r 0} {$r < [llength $annotated]} {incr r} {
            for {set c 0} {$c < [llength [lindex $annotated $r]]} {incr c} {
                if {![isMine $annotated $r $c]} {
                    set count [countMines $annotated $r $c]
                    lset annotated $r $c [expr {$count == 0 ? " " : $count}]
                }
            }
        }

        return [lmap row $annotated {join $row ""}]
    }

    proc countMines {annotated r c} {
        set count 0
        for {set rr [expr {$r - 1}]} {$rr <= $r + 1} {incr rr} {
            for {set cc [expr {$c - 1}]} {$cc <= $c + 1} {incr cc} {
                if {[isMine $annotated $rr $cc]} {
                    incr count
                }
            }
        }
        return $count
    }

    proc isMine {annotated x y} {
        # don't need to check if $x and $y are in range:
        # `lindex $list $invalid_idx` will return an empty string if not.
        expr {[lindex $annotated $x $y] eq "*"}
    }
}

namespace import MineField::annotate
