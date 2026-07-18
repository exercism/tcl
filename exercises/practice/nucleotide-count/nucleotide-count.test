#!/usr/bin/env tclsh
# generated: 2026-07-18T18:53:58Z
package require tcltest
namespace import ::tcltest::*
source testHelpers.tcl

# Uncomment next line to view test durations.
#configure -verbose {body error usec}

############################################################
source "nucleotide-count.tcl"


test nucleotide-count-1 "empty strand" -body {
    nucleotideCounts ""
} -returnCodes ok -match dictionary -result {A 0 C 0 G 0 T 0}

skip nucleotide-count-2
test nucleotide-count-2 "can count one nucleotide in single-character input" -body {
    nucleotideCounts "G"
} -returnCodes ok -match dictionary -result {A 0 C 0 G 1 T 0}

skip nucleotide-count-3
test nucleotide-count-3 "strand with repeated nucleotide" -body {
    nucleotideCounts "GGGGGGG"
} -returnCodes ok -match dictionary -result {A 0 C 0 G 7 T 0}

skip nucleotide-count-4
test nucleotide-count-4 "strand with multiple nucleotides" -body {
    nucleotideCounts "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC"
} -returnCodes ok -match dictionary -result {A 20 C 12 G 17 T 21}

skip nucleotide-count-5
test nucleotide-count-5 "strand with invalid nucleotides" -body {
    nucleotideCounts "AGXXACT"
} -returnCodes error -result "Invalid nucleotide in strand"


cleanupTests
