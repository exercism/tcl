#! tclsh

oo::class create HighScores {
    constructor {} {
        variable scores [list]
    }

    method addScores {args} {
        my variable scores
        lappend scores {*}$args
    }

    method scores {} {
        my variable scores
        return $scores
    }

    method latest {} {
        my variable scores
        return [lindex $scores end]
    }
    
    method personalBest {} {
        my variable scores
        if {[llength $scores] > 0} {
            ::tcl::mathfunc::max {*}$scores
        }
    }

    method topThree {} {
        my variable scores
        lrange [lsort -integer -decreasing $scores] 0 2
    }
}
