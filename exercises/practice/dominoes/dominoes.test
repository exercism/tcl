#!/usr/bin/env tclsh
# generated: 2026-07-17T19:29:02Z
package require tcltest
namespace import ::tcltest::*
source testHelpers.tcl

# Uncomment next line to view test durations.
#configure -verbose {body error usec}

############################################################
source "dominoes.tcl"


test dominoes-1 "empty input = empty output" -body {
    dominoChain {}
} -returnCodes ok -match boolean -result true

skip dominoes-2
test dominoes-2 "singleton input = singleton output" -body {
    dominoChain {{1 1}}
} -returnCodes ok -match boolean -result true

skip dominoes-3
test dominoes-3 "singleton that can't be chained" -body {
    dominoChain {{1 2}}
} -returnCodes ok -match boolean -result false

skip dominoes-4
test dominoes-4 "three elements" -body {
    dominoChain {{1 2} {3 1} {2 3}}
} -returnCodes ok -match boolean -result true

skip dominoes-5
test dominoes-5 "can reverse dominoes" -body {
    dominoChain {{1 2} {1 3} {2 3}}
} -returnCodes ok -match boolean -result true

skip dominoes-6
test dominoes-6 "can't be chained" -body {
    dominoChain {{1 2} {4 1} {2 3}}
} -returnCodes ok -match boolean -result false

skip dominoes-7
test dominoes-7 "disconnected - simple" -body {
    dominoChain {{1 1} {2 2}}
} -returnCodes ok -match boolean -result false

skip dominoes-8
test dominoes-8 "disconnected - double loop" -body {
    dominoChain {{1 2} {2 1} {3 4} {4 3}}
} -returnCodes ok -match boolean -result false

skip dominoes-9
test dominoes-9 "disconnected - single isolated" -body {
    dominoChain {{1 2} {2 3} {3 1} {4 4}}
} -returnCodes ok -match boolean -result false

skip dominoes-10
test dominoes-10 "need backtrack" -body {
    dominoChain {{1 2} {2 3} {3 1} {2 4} {2 4}}
} -returnCodes ok -match boolean -result true

skip dominoes-11
test dominoes-11 "separate loops" -body {
    dominoChain {{1 2} {2 3} {3 1} {1 1} {2 2} {3 3}}
} -returnCodes ok -match boolean -result true

skip dominoes-12
test dominoes-12 "nine elements" -body {
    dominoChain {{1 2} {5 3} {3 1} {1 2} {2 4} {1 6} {2 3} {3 4} {5 6}}
} -returnCodes ok -match boolean -result true

skip dominoes-13
test dominoes-13 "separate three-domino loops" -body {
    dominoChain {{1 2} {2 3} {3 1} {4 5} {5 6} {6 4}}
} -returnCodes ok -match boolean -result false


cleanupTests
