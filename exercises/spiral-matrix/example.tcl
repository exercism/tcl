namespace eval SpiralMatrix {
    proc generate {n} {
        coroutine nextDelta nextDeltaGenerator

        set matrix [lrepeat $n [lrepeat $n "empty"]]
        set x 0
        set y 0
        lassign [nextDelta] dx dy

        for {set i 1} {$i <= $n**2} {incr i} {
            lset matrix $x $y $i

            if { $x+$dx < 0 || $x+$dx == $n ||
                $y+$dy < 0 || $y+$dy == $n ||
                [lindex $matrix $x+$dx $y+$dy] ne "empty"
            } {
                lassign [nextDelta] dx dy
            }

            incr x $dx
            incr y $dy
        }

        rename nextDelta ""     ;# delete the coroutine
        return $matrix
    }

    proc nextDeltaGenerator {} {
        yield [info coroutine]
        set delta {{0 1} {1 0} {0 -1} {-1 0}}
        set idx 0
        while 1 {
            yield [lindex $delta $idx]
            set idx [expr {($idx + 1) % 4}]
        }
    }
}

interp alias {} spiralMatrix {} SpiralMatrix::generate
