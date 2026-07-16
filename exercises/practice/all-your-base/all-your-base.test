#!/usr/bin/env tclsh
# generated: 2026-07-16T21:21:55Z
package require tcltest
namespace import ::tcltest::*
source testHelpers.tcl

# Uncomment next line to view test durations.
#configure -verbose {body error usec}

############################################################
source "all-your-base.tcl"


test all-your-base-1 "single bit one to decimal" -body {
    rebase 2 {1} 10
} -returnCodes ok -result {1}

skip all-your-base-2
test all-your-base-2 "binary to single decimal" -body {
    rebase 2 {1 0 1} 10
} -returnCodes ok -result {5}

skip all-your-base-3
test all-your-base-3 "single decimal to binary" -body {
    rebase 10 {5} 2
} -returnCodes ok -result {1 0 1}

skip all-your-base-4
test all-your-base-4 "binary to multiple decimal" -body {
    rebase 2 {1 0 1 0 1 0} 10
} -returnCodes ok -result {4 2}

skip all-your-base-5
test all-your-base-5 "decimal to binary" -body {
    rebase 10 {4 2} 2
} -returnCodes ok -result {1 0 1 0 1 0}

skip all-your-base-6
test all-your-base-6 "trinary to hexadecimal" -body {
    rebase 3 {1 1 2 0} 16
} -returnCodes ok -result {2 10}

skip all-your-base-7
test all-your-base-7 "hexadecimal to trinary" -body {
    rebase 16 {2 10} 3
} -returnCodes ok -result {1 1 2 0}

skip all-your-base-8
test all-your-base-8 "15-bit integer" -body {
    rebase 97 {3 46 60} 73
} -returnCodes ok -result {6 10 45}

skip all-your-base-9
test all-your-base-9 "empty list" -body {
    rebase 2 {} 10
} -returnCodes ok -result {0}

skip all-your-base-10
test all-your-base-10 "single zero" -body {
    rebase 10 {0} 2
} -returnCodes ok -result {0}

skip all-your-base-11
test all-your-base-11 "multiple zeros" -body {
    rebase 10 {0 0 0} 2
} -returnCodes ok -result {0}

skip all-your-base-12
test all-your-base-12 "leading zeros" -body {
    rebase 7 {0 6 0} 10
} -returnCodes ok -result {4 2}

skip all-your-base-13
test all-your-base-13 "input base is one" -body {
    rebase 1 {0} 10
} -returnCodes error -result "input base must be >= 2"

skip all-your-base-14
test all-your-base-14 "input base is zero" -body {
    rebase 0 {} 10
} -returnCodes error -result "input base must be >= 2"

skip all-your-base-15
test all-your-base-15 "input base is negative" -body {
    rebase -2 {1} 10
} -returnCodes error -result "input base must be >= 2"

skip all-your-base-16
test all-your-base-16 "negative digit" -body {
    rebase 2 {1 -1 1 0 1 0} 10
} -returnCodes error -result "all digits must satisfy 0 <= d < input base"

skip all-your-base-17
test all-your-base-17 "invalid positive digit" -body {
    rebase 2 {1 2 1 0 1 0} 10
} -returnCodes error -result "all digits must satisfy 0 <= d < input base"

skip all-your-base-18
test all-your-base-18 "output base is one" -body {
    rebase 2 {1 0 1 0 1 0} 1
} -returnCodes error -result "output base must be >= 2"

skip all-your-base-19
test all-your-base-19 "output base is zero" -body {
    rebase 10 {7} 0
} -returnCodes error -result "output base must be >= 2"

skip all-your-base-20
test all-your-base-20 "output base is negative" -body {
    rebase 2 {1} -7
} -returnCodes error -result "output base must be >= 2"

skip all-your-base-21
test all-your-base-21 "both bases are negative" -body {
    rebase -2 {1} -7
} -returnCodes error -result "input base must be >= 2"


cleanupTests
