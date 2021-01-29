proc bestHands {hands} {
    foreach hand [lmap hand $hands {PokerHand new $hand}] {
        dict lappend pokerHands [$hand value] $hand
    }
    set max [::tcl::mathfunc::max {*}[dict keys $pokerHands]]
    set winners [dict get $pokerHands $max]

    # now, filter by the hand ranking
    foreach hand $winners {
        dict lappend winningHands [$hand rankingValue] $hand
    }
    set max [::tcl::mathfunc::max {*}[dict keys $winningHands]]
    set winners [dict get $winningHands $max]

    return [lmap hand $winners {$hand toString}]
}

############################################################
oo::class create Card {
    variable face suit

    constructor {string} {
        if {![regexp {^([2-9JQKA]|10)([DCSH])$} $string -> f s]} {
            error "Invalid card: $string"
        }
        set face $f
        set suit $s
    }

    method face {} {
        return $face
    }

    method suit {} {
        return $suit
    }

    method value {} {
        switch $face {
            A { return 14 }
            K { return 13 }
            Q { return 12 }
            J { return 11 }
            default { return $face }
        }
    }
}

############################################################
oo::class create PokerHand {
    variable original
    variable cards
    variable ranking
    variable value
    variable groupings

    constructor {string} {
        set original $string
        set cards [lmap c [split $string] {Card new $c}]
        set ranking {}
        set value -1
    }

    method toString {} {
        return $original
    }

    method value {} {
        if {$value == -1} {
            set value [my EvaluateHand]
        }
        return $value
    }

    method rankingValue {} {
        set val 0
        foreach r $ranking {
            set val [expr {14 * $val + $r}]
        }
        return $val
    }


    method EvaluateHand {} {
        # find the X-of-a-kind groups in this hand.
        foreach card $cards {
            dict incr groupings [$card value]
        }

        # default ranking
        if {[my IsFiveOfAKind]}   { return 9 }
        if {[my IsStraightFlush]} { return 8 }
        if {[my IsFourOfAKind]}   { return 7 }
        if {[my IsFullHouse]}     { return 6 }
        if {[my IsFlush]}         { return 5 }
        if {[my IsStraight]}      { return 4 }
        if {[my IsThreeOfAKind]}  { return 3 }
        if {[my IsTwoPairs]}      { return 2 }
        if {[my IsOnePair]}       { return 1 }

        set ranking [my RankCardValues]
        return 0
    }

    method IsFiveOfAKind {} {
        if {[llength $groupings] == 1} {
            set ranking [[lindex $cards 0] value]
            return true
        }
        return false
    }

    method IsStraightFlush {} {
        return [expr {[my IsFlush] && [my IsStraight]}]
    }

    method IsFourOfAKind {} {
        return [my HasGroupings {4 1}]
    }

    method IsFullHouse {} {
        return [my HasGroupings {3 2}]
    }

    method IsFlush {} {
        set suit [[lindex $cards 0] suit]
        foreach card $cards {
            if {$suit ne [$card suit]} {
                return false
            }
        }
        set ranking [my RankCardValues]
        return true
    }

    method IsStraight {} {
        set values [my RankCardValues]

        # is Ace-low straight?
        if {$values eq {14 5 4 3 2}} {
            set ranking 5  ;# highest card in this straight
            return true
        }

        set first [lindex $values 0]
        set seq [my Seq $first]     ;# e.g. {10 9 8 7 6}
        if {$values eq $seq} {
            set ranking $first
            return true
        }
        return false
    }

    method Seq {start} {
        set seq [list $start]
        foreach i {1 2 3 4} {
            lappend seq [incr start -1]
        }
        return $seq
    }

    method IsThreeOfAKind {} {
        return [my HasGroupings {3 1 1}]
    }

    method IsTwoPairs {} {
        return [my HasGroupings {2 2 1}]
    }

    method IsOnePair {} {
        return [my HasGroupings {2 1 1 1}]
    }

    # e.g. the hand {AC AH AD 10S 10D}
    # will have values {14 14 14 10 10}
    # and grouping {14 3 10 2}
    # and HasGrouping {3 2} will be true
    #
    method HasGroupings {wanted} {
        set groupCounts [lsort -decr -int [dict values $groupings]]
        if {$groupCounts eq $wanted} {
            # sort by card value
            set groupings [lsort -index 0 -stride 2 -int -decr $groupings]
            # then sort by group size
            set groupings [lsort -index 1 -stride 2 -int -decr $groupings]
            set ranking [dict keys $groupings]
            return true
        }
        return false
    }

    method RankCardValues {} {
        return [lsort -decr -int [lmap card $cards {$card value}]]
    }
}
