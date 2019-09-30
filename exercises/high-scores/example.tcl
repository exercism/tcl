#! tclsh

oo::class create HighScores {
    variable scores

    constructor {} {
        set scores {}
    }

    method addScores {args} {
        lappend scores {*}$args
    }

    method scores {} {
        return $scores
    }

    method latest {} {
        return [lindex $scores end]
    }
    
    method personalBest {} {
        if {[llength $scores] > 0} {
            ::tcl::mathfunc::max {*}$scores
        }
    }

    method topThree {} {
        lrange [lsort -integer -decreasing $scores] 0 2
    }
}
