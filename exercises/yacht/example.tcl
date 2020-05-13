oo::class create Yacht {
    variable dice
    variable groups

    constructor {theDice} {
        set dice [lsort -integer $theDice]

        set groups {1 0 2 0 3 0 4 0 5 0 6 0}
        foreach d $dice {
            dict incr groups $d
        }
    }

    forward ones    my Number 1
    forward twos    my Number 2
    forward threes  my Number 3
    forward fours   my Number 4
    forward fives   my Number 5
    forward sixes   my Number 6

    method Number {num} {
        return [expr {$num * [dict get $groups $num]}]
    }

    method yacht {} {
        return [expr {5 in [dict values $groups] ? 50 : 0}]
    }

    method choice {} {
        foreach d $dice {incr sum $d}
        return $sum
    }

    method "full house" {} {
        set score 0
        if {2 in [dict values $groups] && 3 in [dict values $groups]} {
            set score [my choice]
        }
        return $score
    }

    method "four of a kind" {} {
        set score 0
        dict for {die num} $groups {
            # 5 of a kind can be scored as 4 of a kind
            if {$num in {4 5}} {
                set score [expr {4 * $die}]
                break
            }
        }
        return $score
    }

    forward "little straight" my Straight 1
    forward "big straight"    my Straight 2

    method Straight {start} {
        set score 0
        set a [lindex $dice 0]
        if {$a == $start} {
            set score 30
            foreach i {1 2 3 4} {
                set b [lindex $dice $i]
                if {$a + 1 != $b} {
                    set score 0
                    break
                }
                set a $b
            }
        }
        return $score
    }

    # the "missing method" handler
    method unknown {args} {
        return -code error "Invalid category"
    }
}

############################################################
proc score {dice category} {
    return [[Yacht new $dice] $category]
}
