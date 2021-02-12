namespace eval Dominoes {
    namespace export dominoChain

    proc dominoChain {dominoes} {
        if {[llength $dominoes] == 0} {
            return true
        }

        for {set i 0} {$i < [llength $dominoes]} {incr i} {
            set d [lindex $dominoes $i]
            set rest [lreplace $dominoes $i $i]

            set chain [buildChain [list $d] $rest]
            if {[llength $chain] == 0} {
                # try again, but flip this starting domino
                set chain [buildChain [list [lreverse $d]] $rest]
            }

            if {[llength $chain] > 0} {
                return true
            }
        }

        return false
    }

    # returns an empty list if no chain is possible
    # otherwise, returns the chain
    #
    proc buildChain {chain available} {
        set tail [lindex $chain end end]

        if {[llength $available] == 0} {
            set head [lindex $chain 0 0]
            if {$head == $tail} {
                return $chain
            } else {
                return {}
            }
        }

        for {set i 0} {$i < [llength $available]} {incr i} {
            set d [lindex $available $i]
            if {$tail ni $d} {
                continue
            }
            if {[lindex $d 0] != $tail} {
                set d [lreverse $d]
            }
            set newChain [buildChain \
                [linsert $chain end $d] \
                [lreplace $available $i $i] \
            ]
            if {[llength $newChain] > 0} {
                return $newChain
            }
        }

        return {}
    }
}

namespace import Dominoes::dominoChain
