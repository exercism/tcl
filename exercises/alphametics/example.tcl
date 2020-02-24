namespace eval alphametics {
    namespace export solve

    proc solve {puzzle} {
        set letters [lsort -unique [regexp -all -inline {[A-Z]} $puzzle]]
        foreach digits [permutations {0 1 2 3 4 5 6 7 8 9} [llength $letters]] {
            set map [zip $letters $digits]
            set expression [string map $map $puzzle]
            if {[regexp {\m0} $expression]} {
                # no operands with leading zeroes
                continue
            }
            if {[expr "$expression"]} {
                return $map
            }
        }
        return
    }


    # taken from https://wiki.tcl-lang.org/page/Combinatorial+mathematics+functions
    proc permutations { list size } {
        if { $size == 0 } {
            return [list [list]]
        }
        set retval {}
        for { set i 0 } { $i < [llength $list] } { incr i } {
            set firstElement [lindex $list $i]
            set remainingElements [lreplace $list $i $i]
            foreach subset [permutations $remainingElements [expr { $size - 1 }]] {
                lappend retval [linsert $subset 0 $firstElement]
            }
        }
        return $retval
    }

    proc zip {letters digits} {
        set map {}
        foreach l $letters d $digits {
            lappend map $l $d
        }
        return $map
    }
}

namespace import alphametics::solve

# timings for a test run:
#   alphametics-1:      3543 microseconds per iteration
#   alphametics-2:       364 microseconds per iteration
#   alphametics-3:     27510 microseconds per iteration
#   alphametics-4:      4987 microseconds per iteration
#   alphametics-5:     24573 microseconds per iteration
#   alphametics-6:    301756 microseconds per iteration
#   alphametics-6:   2220392 microseconds per iteration
#   alphametics-8:   9862008 microseconds per iteration
#   alphametics-9:  24080449 microseconds per iteration
#   alphametics-10: 28920954 microseconds per iteration
#
