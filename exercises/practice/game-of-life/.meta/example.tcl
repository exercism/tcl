namespace eval GameOfLife {
    namespace export tick

    proc tick {matrix} {
        set nrows [llength $matrix]
        set ncols [llength [lindex $matrix 0]]
        set next [lrepeat $nrows [lrepeat $ncols 0]]

        for {set r 0} {$r < $nrows} {incr r} {
            for {set c 0} {$c < $ncols} {incr c} {
                switch [neighbourCount $matrix $r $c] {
                    3 { lset next $r $c 1 }
                    2 { lset next $r $c [lindex $matrix $r $c] }
                }
            }
        }
        return $next
    }

    proc neighbourCount {matrix r c} {
        set count 0
        foreach dr {-1 0 1} {
            foreach dc {-1 0 1} {
                if {!($dr == 0 && $dc == 0)} {
                    set value [lindex $matrix $r+$dr $c+$dc]
                    # if indices outside of matrix, value is empty string
                    incr count [expr {$value eq "" ? 0 : $value}]
                }
            }
        }
        return $count
    }
}

namespace import GameOfLife::tick
