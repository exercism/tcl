#!/usr/bin/env tclsh
# generated: 2026-07-27T16:08:11Z
package require tcltest
namespace import ::tcltest::*
source testHelpers.tcl

# Uncomment next line to view test durations.
#configure -verbose {body error usec}

############################################################
source "strain.tcl"


test strain-1 "keep on empty list returns empty list" -body {
    keep x {} {expr {true}}
} -returnCodes ok -result {}

skip strain-2
test strain-2 "keeps everything" -body {
    keep x {1 3 5} {expr {true}}
} -returnCodes ok -result {1 3 5}

skip strain-3
test strain-3 "keeps nothing" -body {
    keep x {1 3 5} {expr {false}}
} -returnCodes ok -result {}

skip strain-4
test strain-4 "keeps first and last" -body {
    keep x {1 2 3} {expr {$x % 2 == 1}}
} -returnCodes ok -result {1 3}

skip strain-5
test strain-5 "keeps neither first nor last" -body {
    keep x {1 2 3} {expr {$x % 2 == 0}}
} -returnCodes ok -result {2}

skip strain-6
test strain-6 "keeps strings" -body {
    keep x {apple zebra banana zombies cherimoya zealot} {string match {z*} $x}
} -returnCodes ok -result {zebra zombies zealot}

skip strain-7
test strain-7 "keeps lists" -body {
    set rows {
        {1 2 3}
        {5 5 5}
        {5 1 2}
        {2 1 2}
        {1 5 2}
        {2 2 1}
        {1 2 5}
    }
    keep x $rows {expr {5 in $x}}
} -returnCodes ok -match listOfLists -result {
    {5 5 5}
    {5 1 2}
    {1 5 2}
    {1 2 5}
}

skip strain-8
test strain-8 "discard on empty list returns empty list" -body {
    discard x {} {expr {true}}
} -returnCodes ok -result {}

skip strain-9
test strain-9 "discards everything" -body {
    discard x {1 3 5} {expr {true}}
} -returnCodes ok -result {}

skip strain-10
test strain-10 "discards nothing" -body {
    discard x {1 3 5} {expr {false}}
} -returnCodes ok -result {1 3 5}

skip strain-11
test strain-11 "discards first and last" -body {
    discard x {1 2 3} {expr {$x % 2 == 1}}
} -returnCodes ok -result {2}

skip strain-12
test strain-12 "discards neither first nor last" -body {
    discard x {1 2 3} {expr {$x % 2 == 0}}
} -returnCodes ok -result {1 3}

skip strain-13
test strain-13 "discards strings" -body {
    discard x {apple zebra banana zombies cherimoya zealot} {string match {z*} $x}
} -returnCodes ok -result {apple banana cherimoya}

skip strain-14
test strain-14 "discards lists" -body {
    set rows {
        {1 2 3}
        {5 5 5}
        {5 1 2}
        {2 1 2}
        {1 5 2}
        {2 2 1}
        {1 2 5}
    }
    discard x $rows {expr {5 in $x}}
} -returnCodes ok -match listOfLists -result {
    {1 2 3}
    {2 1 2}
    {2 2 1}
}


cleanupTests
