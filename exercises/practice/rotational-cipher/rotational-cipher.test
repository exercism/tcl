#!/usr/bin/env tclsh
# generated: 2026-07-23T16:04:54Z
package require tcltest
namespace import ::tcltest::*
source testHelpers.tcl

# Uncomment next line to view test durations.
#configure -verbose {body error usec}

############################################################
source "rotational-cipher.tcl"


test rotational-cipher-1 "rotate a by 0, same output as input" -body {
    rotate "a" 0
} -returnCodes ok -result "a"

skip rotational-cipher-2
test rotational-cipher-2 "rotate a by 1" -body {
    rotate "a" 1
} -returnCodes ok -result "b"

skip rotational-cipher-3
test rotational-cipher-3 "rotate a by 26, same output as input" -body {
    rotate "a" 26
} -returnCodes ok -result "a"

skip rotational-cipher-4
test rotational-cipher-4 "rotate m by 13" -body {
    rotate "m" 13
} -returnCodes ok -result "z"

skip rotational-cipher-5
test rotational-cipher-5 "rotate n by 13 with wrap around alphabet" -body {
    rotate "n" 13
} -returnCodes ok -result "a"

skip rotational-cipher-6
test rotational-cipher-6 "rotate capital letters" -body {
    rotate "OMG" 5
} -returnCodes ok -result "TRL"

skip rotational-cipher-7
test rotational-cipher-7 "rotate spaces" -body {
    rotate "O M G" 5
} -returnCodes ok -result "T R L"

skip rotational-cipher-8
test rotational-cipher-8 "rotate numbers" -body {
    rotate "Testing 1 2 3 testing" 4
} -returnCodes ok -result "Xiwxmrk 1 2 3 xiwxmrk"

skip rotational-cipher-9
test rotational-cipher-9 "rotate punctuation" -body {
    rotate "Let's eat, Grandma!" 21
} -returnCodes ok -result "Gzo'n zvo, Bmviyhv!"

skip rotational-cipher-10
test rotational-cipher-10 "rotate all letters" -body {
    rotate "The quick brown fox jumps over the lazy dog." 13
} -returnCodes ok -result "Gur dhvpx oebja sbk whzcf bire gur ynml qbt."


cleanupTests
