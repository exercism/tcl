#!/usr/bin/env tclsh
# generated: 2026-07-23T00:58:50Z
package require tcltest
namespace import ::tcltest::*
source testHelpers.tcl

# Uncomment next line to view test durations.
#configure -verbose {body error usec}

############################################################
source "prime-factors.tcl"


test prime-factors-1 "no factors" -body {
    factors 1
} -returnCodes ok -result {}

skip prime-factors-2
test prime-factors-2 "prime number" -body {
    factors 2
} -returnCodes ok -result 2

skip prime-factors-3
test prime-factors-3 "another prime number" -body {
    factors 3
} -returnCodes ok -result 3

skip prime-factors-4
test prime-factors-4 "square of a prime" -body {
    factors 9
} -returnCodes ok -result {3 3}

skip prime-factors-5
test prime-factors-5 "product of first prime" -body {
    factors 4
} -returnCodes ok -result {2 2}

skip prime-factors-6
test prime-factors-6 "cube of a prime" -body {
    factors 8
} -returnCodes ok -result {2 2 2}

skip prime-factors-7
test prime-factors-7 "product of second prime" -body {
    factors 27
} -returnCodes ok -result {3 3 3}

skip prime-factors-8
test prime-factors-8 "product of third prime" -body {
    factors 625
} -returnCodes ok -result {5 5 5 5}

skip prime-factors-9
test prime-factors-9 "product of first and second prime" -body {
    factors 6
} -returnCodes ok -result {2 3}

skip prime-factors-10
test prime-factors-10 "product of primes and non-primes" -body {
    factors 12
} -returnCodes ok -result {2 2 3}

skip prime-factors-11
test prime-factors-11 "product of primes" -body {
    factors 901255
} -returnCodes ok -result {5 17 23 461}

skip prime-factors-12
test prime-factors-12 "factors include a large prime" -body {
    factors 93819012551
} -returnCodes ok -result {11 9539 894119}


cleanupTests
