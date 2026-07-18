#!/usr/bin/env tclsh
# generated: 2026-07-18T01:15:07Z
package require tcltest
namespace import ::tcltest::*
source testHelpers.tcl

# Uncomment next line to view test durations.
#configure -verbose {body error usec}

############################################################
source "hamming.tcl"


test hamming-1 "empty strands" -body {
    hammingDistance "" ""
} -returnCodes ok -result 0

skip hamming-2
test hamming-2 "single letter identical strands" -body {
    hammingDistance "A" "A"
} -returnCodes ok -result 0

skip hamming-3
test hamming-3 "single letter different strands" -body {
    hammingDistance "G" "T"
} -returnCodes ok -result 1

skip hamming-4
test hamming-4 "long identical strands" -body {
    hammingDistance "GGACTGAAATCTG" "GGACTGAAATCTG"
} -returnCodes ok -result 0

skip hamming-5
test hamming-5 "long different strands" -body {
    hammingDistance "GGACGGATTCTG" "AGGACGGATTCT"
} -returnCodes ok -result 9

skip hamming-6
test hamming-6 "disallow first strand longer" -body {
    hammingDistance "AATG" "AAA"
} -returnCodes error -result "strands must be of equal length"

skip hamming-7
test hamming-7 "disallow second strand longer" -body {
    hammingDistance "ATA" "AGTG"
} -returnCodes error -result "strands must be of equal length"

skip hamming-8
test hamming-8 "disallow empty first strand" -body {
    hammingDistance "" "G"
} -returnCodes error -result "strands must be of equal length"

skip hamming-9
test hamming-9 "disallow empty second strand" -body {
    hammingDistance "G" ""
} -returnCodes error -result "strands must be of equal length"


cleanupTests
