#!/usr/bin/env tclsh
# generated: 2026-07-17T10:42:04Z
package require tcltest
namespace import ::tcltest::*
source testHelpers.tcl

# Uncomment next line to view test durations.
#configure -verbose {body error usec}

############################################################
source "bowling.tcl"


test bowling-1 "should be able to score a game with all zeros" -body {
    set game [Bowling new]
    foreach roll {0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0} {
        $game roll $roll
    }
    $game score
} -returnCodes ok -result 0

skip bowling-2
test bowling-2 "should be able to score a game with no strikes or spares" -body {
    set game [Bowling new]
    foreach roll {3 6 3 6 3 6 3 6 3 6 3 6 3 6 3 6 3 6 3 6} {
        $game roll $roll
    }
    $game score
} -returnCodes ok -result 90

skip bowling-3
test bowling-3 "a spare followed by zeros is worth ten points" -body {
    set game [Bowling new]
    foreach roll {6 4 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0} {
        $game roll $roll
    }
    $game score
} -returnCodes ok -result 10

skip bowling-4
test bowling-4 "points scored in the roll after a spare are counted twice" -body {
    set game [Bowling new]
    foreach roll {6 4 3 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0} {
        $game roll $roll
    }
    $game score
} -returnCodes ok -result 16

skip bowling-5
test bowling-5 "consecutive spares each get a one roll bonus" -body {
    set game [Bowling new]
    foreach roll {5 5 3 7 4 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0} {
        $game roll $roll
    }
    $game score
} -returnCodes ok -result 31

skip bowling-6
test bowling-6 "a spare in the last frame gets a one roll bonus that is counted once" -body {
    set game [Bowling new]
    foreach roll {0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 7 3 7} {
        $game roll $roll
    }
    $game score
} -returnCodes ok -result 17

skip bowling-7
test bowling-7 "a strike earns ten points in a frame with a single roll" -body {
    set game [Bowling new]
    foreach roll {10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0} {
        $game roll $roll
    }
    $game score
} -returnCodes ok -result 10

skip bowling-8
test bowling-8 "points scored in the two rolls after a strike are counted twice as a bonus" -body {
    set game [Bowling new]
    foreach roll {10 5 3 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0} {
        $game roll $roll
    }
    $game score
} -returnCodes ok -result 26

skip bowling-9
test bowling-9 "consecutive strikes each get the two roll bonus" -body {
    set game [Bowling new]
    foreach roll {10 10 10 5 3 0 0 0 0 0 0 0 0 0 0 0 0} {
        $game roll $roll
    }
    $game score
} -returnCodes ok -result 81

skip bowling-10
test bowling-10 "a strike in the last frame gets a two roll bonus that is counted once" -body {
    set game [Bowling new]
    foreach roll {0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 7 1} {
        $game roll $roll
    }
    $game score
} -returnCodes ok -result 18

skip bowling-11
test bowling-11 "rolling a spare with the two roll bonus does not get a bonus roll" -body {
    set game [Bowling new]
    foreach roll {0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 7 3} {
        $game roll $roll
    }
    $game score
} -returnCodes ok -result 20

skip bowling-12
test bowling-12 "strikes with the two roll bonus do not get bonus rolls" -body {
    set game [Bowling new]
    foreach roll {0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 10 10} {
        $game roll $roll
    }
    $game score
} -returnCodes ok -result 30

skip bowling-13
test bowling-13 "last two strikes followed by only last bonus with non strike points" -body {
    set game [Bowling new]
    foreach roll {0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 10 0 1} {
        $game roll $roll
    }
    $game score
} -returnCodes ok -result 31

skip bowling-14
test bowling-14 "a strike with the one roll bonus after a spare in the last frame does not get a bonus" -body {
    set game [Bowling new]
    foreach roll {0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 7 3 10} {
        $game roll $roll
    }
    $game score
} -returnCodes ok -result 20

skip bowling-15
test bowling-15 "all strikes is a perfect game" -body {
    set game [Bowling new]
    foreach roll {10 10 10 10 10 10 10 10 10 10 10 10} {
        $game roll $roll
    }
    $game score
} -returnCodes ok -result 300

skip bowling-16
test bowling-16 "rolls cannot score negative points" -body {
    set game [Bowling new]
    $game roll -1
    $game score
} -returnCodes error -result "Negative roll is invalid"

skip bowling-17
test bowling-17 "a roll cannot score more than 10 points" -body {
    set game [Bowling new]
    $game roll 11
    $game score
} -returnCodes error -result "Pin count exceeds pins on the lane"

skip bowling-18
test bowling-18 "two rolls in a frame cannot score more than 10 points" -body {
    set game [Bowling new]
    $game roll 5
    $game roll 6
    $game score
} -returnCodes error -result "Pin count exceeds pins on the lane"

skip bowling-19
test bowling-19 "bonus roll after a strike in the last frame cannot score more than 10 points" -body {
    set game [Bowling new]
    foreach roll {0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10} {
        $game roll $roll
    }
    $game roll 11
    $game score
} -returnCodes error -result "Pin count exceeds pins on the lane"

skip bowling-20
test bowling-20 "two bonus rolls after a strike in the last frame cannot score more than 10 points" -body {
    set game [Bowling new]
    foreach roll {0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 5} {
        $game roll $roll
    }
    $game roll 6
    $game score
} -returnCodes error -result "Pin count exceeds pins on the lane"

skip bowling-21
test bowling-21 "two bonus rolls after a strike in the last frame can score more than 10 points if one is a strike" -body {
    set game [Bowling new]
    foreach roll {0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 10 6} {
        $game roll $roll
    }
    $game score
} -returnCodes ok -result 26

skip bowling-22
test bowling-22 "the second bonus rolls after a strike in the last frame cannot be a strike if the first one is not a strike" -body {
    set game [Bowling new]
    foreach roll {0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 6} {
        $game roll $roll
    }
    $game roll 10
    $game score
} -returnCodes error -result "Pin count exceeds pins on the lane"

skip bowling-23
test bowling-23 "second bonus roll after a strike in the last frame cannot score more than 10 points" -body {
    set game [Bowling new]
    foreach roll {0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 10} {
        $game roll $roll
    }
    $game roll 11
    $game score
} -returnCodes error -result "Pin count exceeds pins on the lane"

skip bowling-24
test bowling-24 "an unstarted game cannot be scored" -body {
    set game [Bowling new]
    $game score
} -returnCodes error -result "Score cannot be taken until the end of the game"

skip bowling-25
test bowling-25 "an incomplete game cannot be scored" -body {
    set game [Bowling new]
    foreach roll {0 0} {
        $game roll $roll
    }
    $game score
} -returnCodes error -result "Score cannot be taken until the end of the game"

skip bowling-26
test bowling-26 "cannot roll if game already has ten frames" -body {
    set game [Bowling new]
    foreach roll {0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0} {
        $game roll $roll
    }
    $game roll 0
    $game score
} -returnCodes error -result "Cannot roll after game is over"

skip bowling-27
test bowling-27 "bonus rolls for a strike in the last frame must be rolled before score can be calculated" -body {
    set game [Bowling new]
    foreach roll {0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10} {
        $game roll $roll
    }
    $game score
} -returnCodes error -result "Score cannot be taken until the end of the game"

skip bowling-28
test bowling-28 "both bonus rolls for a strike in the last frame must be rolled before score can be calculated" -body {
    set game [Bowling new]
    foreach roll {0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 10} {
        $game roll $roll
    }
    $game score
} -returnCodes error -result "Score cannot be taken until the end of the game"

skip bowling-29
test bowling-29 "bonus roll for a spare in the last frame must be rolled before score can be calculated" -body {
    set game [Bowling new]
    foreach roll {0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 7 3} {
        $game roll $roll
    }
    $game score
} -returnCodes error -result "Score cannot be taken until the end of the game"

skip bowling-30
test bowling-30 "cannot roll after bonus roll for spare" -body {
    set game [Bowling new]
    foreach roll {0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 7 3 2} {
        $game roll $roll
    }
    $game roll 2
    $game score
} -returnCodes error -result "Cannot roll after game is over"

skip bowling-31
test bowling-31 "cannot roll after bonus rolls for strike" -body {
    set game [Bowling new]
    foreach roll {0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 3 2} {
        $game roll $roll
    }
    $game roll 2
    $game score
} -returnCodes error -result "Cannot roll after game is over"


cleanupTests
