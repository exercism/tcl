# This solution encodes the X and O positions into an integer.
# The cells of the board are numbered like this:
#   1 2 3
#   4 5 6
#   7 8 9
#
# Given a board like
#   X X O
#   O X .
#   . X O
# The value for X will have bits 1, 2, 5, 8 set == 010010011 == 147
# The value for O will have bits 3, 4, 9    set == 100001100 == 268

namespace eval StateOfTicTacToe {
    namespace export gamestate

    variable wins {
        0b001001001
        0b010010010
        0b100100100
        0b000000111
        0b000111000
        0b111000000
        0b100010001
        0b001010100
    }

    proc gamestate {board} {
        lassign [parse $board] X O

        switch [list [won $X] [won $O]] {
            {true true} {error "Impossible board: game should have ended after the game was won"}

            {true false} -
            {false true} {return "win"}

            default {
                set xBits [bitCount $X]
                set oBits [bitCount $O]
                if {$xBits - $oBits > 1} then {error "Wrong turn order: X went twice"}
                if {$xBits - $oBits < 0} then {error "Wrong turn order: O started"}
                return [expr {$xBits + $oBits == 9 ? "draw" : "ongoing"}]
            }
        }
    }

    proc parse {board} {
        set X 0
        set O 0
        set i 1

        foreach cell [split [string cat {*}$board] ""] {
            if {$cell in {X O}} then {setBit $cell $i}
            incr i
        }
        return [list $X $O]
    }

    proc setBit {varname pos} {
        upvar 1 $varname var
        set var [expr {$var | (1 << ($pos - 1))}]
    }

    proc bitCount {n} {
        set count 0
        while {$n > 0} {
            incr count [expr {$n & 1}]
            set n [expr {$n >> 1}]
        }
        return $count
    }

    proc won {player} {
        variable wins
        foreach combo $wins {
            if {($player & $combo) == $combo} {
                return true
            }
        }
        return false
    }
}

namespace import StateOfTicTacToe::gamestate
