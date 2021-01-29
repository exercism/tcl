oo::class create Bowling {
    variable score
    variable frame
    variable current
    variable bonuses

    constructor {} {
        set score 0
        set frame 1
        set current {}  ;# rolls in the current frame
        set bonuses {}  ;# strikes&spares we're still counting
    }

    method score {} {
        if {$frame <= 10} {
            error "Score cannot be taken until the end of the game"
        }
        return $score
    }

    method roll {pins} {
        if {$frame > 10} {
            error "Cannot roll after game is over"
        }
        if {$pins < 0} {
            error "Negative roll is invalid"
        }
        if {[my TooManyPins $pins]} {
            error "Pin count exceeds pins on the lane"
        }

        my AddScore $pins
        my HandleFrame $pins
    }


    # private methods

    method AddScore {pins} {
        incr score $pins
        for {set i 0} {$i < [llength $bonuses]} {incr i} {
            set b [lindex $bonuses $i]
            if {$b > 0} {
                incr score $pins
                lset bonuses $i [expr {$b - 1}]
            }
        }
        return
    }

    method HandleFrame {pins} {
        if {$frame < 10} {
            my HandleFrameNth $pins
        } else {
            my HandleFrameTenth $pins
        }
        return
    }

    method HandleFrameNth {pins} {
        if {$pins == 10} {
            # strike
            lappend bonuses 2
            incr frame
        } elseif {[llength $current] == 0} {
            lappend current $pins
        } elseif {[llength $current] == 1} {
            if {[lindex $current 0] + $pins == 10} {
                # spare
                lappend bonuses 1
            }
            incr frame
            set current {}
        }
        return
    }

    method HandleFrameTenth {pins} {
        lappend current $pins
        set len [llength $current]
        set sum [::tcl::mathop::+ {*}$current]
        if {$len == 3 || ($len == 2 && $sum < 10)} {
            incr frame
        }
        return
    }

    method TooManyPins {pins} {
        if {$pins > 10} {
            return true
        }
        if {[llength $current] == 0} {
            return false
        }
        if {$frame == 10} {
            return [my TooManyPinsTenth $pins]
        }
        return [expr {[lindex $current 0] + $pins > 10}]
    }

    method TooManyPinsTenth {pins} {
        set nonStrikes [lmap roll $current {
            expr {$roll == 10 ? [continue] : $roll}
        }]
        set len [llength $nonStrikes]
        set sum [::tcl::mathop::+ {*}$nonStrikes]
        if {$len == 0 || ($len == 2 && $sum == 10)} {
            return false
        }
        return [expr {[lindex $nonStrikes 0] + $pins > 10}]
    }
}
