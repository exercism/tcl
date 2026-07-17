#!/usr/bin/env tclsh
# generated: 2026-07-17T23:34:10Z
package require tcltest
namespace import ::tcltest::*
source testHelpers.tcl

# Uncomment next line to view test durations.
#configure -verbose {body error usec}

############################################################
source "game-of-life.tcl"


test game-of-life-1 "empty matrix" -body {
    tick {}
} -returnCodes ok -match listOfLists -result {}

skip game-of-life-2
test game-of-life-2 "live cells with zero live neighbors die" -body {
    tick {
        {0 0 0}
        {0 1 0}
        {0 0 0}
    }
} -returnCodes ok -match listOfLists -result {
        {0 0 0}
        {0 0 0}
        {0 0 0}
    }

skip game-of-life-3
test game-of-life-3 "live cells with only one live neighbor die" -body {
    tick {
        {0 0 0}
        {0 1 0}
        {0 1 0}
    }
} -returnCodes ok -match listOfLists -result {
        {0 0 0}
        {0 0 0}
        {0 0 0}
    }

skip game-of-life-4
test game-of-life-4 "live cells with two live neighbors stay alive" -body {
    tick {
        {1 0 1}
        {1 0 1}
        {1 0 1}
    }
} -returnCodes ok -match listOfLists -result {
        {0 0 0}
        {1 0 1}
        {0 0 0}
    }

skip game-of-life-5
test game-of-life-5 "live cells with three live neighbors stay alive" -body {
    tick {
        {0 1 0}
        {1 0 0}
        {1 1 0}
    }
} -returnCodes ok -match listOfLists -result {
        {0 0 0}
        {1 0 0}
        {1 1 0}
    }

skip game-of-life-6
test game-of-life-6 "dead cells with three live neighbors become alive" -body {
    tick {
        {1 1 0}
        {0 0 0}
        {1 0 0}
    }
} -returnCodes ok -match listOfLists -result {
        {0 0 0}
        {1 1 0}
        {0 0 0}
    }

skip game-of-life-7
test game-of-life-7 "live cells with four or more neighbors die" -body {
    tick {
        {1 1 1}
        {1 1 1}
        {1 1 1}
    }
} -returnCodes ok -match listOfLists -result {
        {1 0 1}
        {0 0 0}
        {1 0 1}
    }

skip game-of-life-8
test game-of-life-8 "bigger matrix" -body {
    tick {
        {1 1 0 1 1 0 0 0}
        {1 0 1 1 0 0 0 0}
        {1 1 1 0 0 1 1 1}
        {0 0 0 0 0 1 1 0}
        {1 0 0 0 1 1 0 0}
        {1 1 0 0 0 1 1 1}
        {0 0 1 0 1 0 0 1}
        {1 0 0 0 0 0 1 1}
    }
} -returnCodes ok -match listOfLists -result {
        {1 1 0 1 1 0 0 0}
        {0 0 0 0 0 1 1 0}
        {1 0 1 1 1 1 0 1}
        {1 0 0 0 0 0 0 1}
        {1 1 0 0 1 0 0 1}
        {1 1 0 1 0 0 0 1}
        {1 0 0 0 0 0 0 0}
        {0 0 0 0 0 0 1 1}
    }


cleanupTests
