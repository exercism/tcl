oo::class create Camicia {
    variable playerA
    variable playerB
    variable pile
    variable result
    variable statesSeen

    constructor {a b} {
        set playerA $a
        set playerB $b
        set pile [list]
        set result {tricks 0 cards 0 status ""}
        set statesSeen [dict create]
    }

    method play {} {
        set currentPlayer playerA
        set otherPlayer playerB

        while true {
            if {[my IsLoop]} {
                dict set result status loop
                break
            }

            if {[my IsEmpty $currentPlayer]} {
                my CollectTrick $otherPlayer
                dict set result status finished
                break
            }

            set card [my Discard $currentPlayer]

            if {[my IsNumberCard $card]} {
                # next player's turn
                lassign [list $otherPlayer $currentPlayer] currentPlayer otherPlayer

            } else {
                # pay the penalty
                lassign [my PayPenalty $card $otherPlayer $currentPlayer] currentPlayer otherPlayer
                my CollectTrick $currentPlayer
                if {[my IsEmpty $otherPlayer]} {
                    dict set result status finished
                    break
                }
            }
        }
        return $result
    }

    method IsEmpty {player} {
        expr {[llength [set $player]] == 0}
    }

    method Discard {player} {
        set card [lpop $player 0]
        lappend pile $card
        dict incr result cards
        return $card
    }

    # returns the next currentPlayer and otherPlayer
    method PayPenalty {card payer payee} {
        for {set n [my Penalty $card]} {$n > 0} {incr n -1} {
            if {[my IsEmpty $payer]} {
                return [list $payee $payer]
            }
            set card [my Discard $payer]
            if {![my IsNumberCard $card]} {
                tailcall my PayPenalty $card $payee $payer
            }
        }
        return [list $payee $payer]
    }

    method Penalty {card} {
        dict getwithdefault {J 1 Q 2 K 3 A 4} $card 0
    }

    method IsNumberCard {card} {
        expr {[my Penalty $card] == 0}
    }

    method CollectTrick {player} {
        lappend $player {*}$pile
        set pile {}
        dict incr result tricks
    }

    method IsLoop {} {
        set state [string cat [my State $playerA] ":" [my State $playerB]]
        if {[dict exists $statesSeen $state]} {
            return true
        }
        dict set statesSeen $state 1
        return false
    }

    method State {hand} {
        # encode the hand as a base-5 number
        set sum 0
        foreach card $hand {
            set sum [expr {$sum * 5 + [my Penalty $card]}]
        }
        # and the state of the hand is the (sum, length) pair
        string cat $sum "," [llength $hand]
    }
}

proc simulateGame {playerA playerB} {
    [Camicia new $playerA $playerB] play
}
