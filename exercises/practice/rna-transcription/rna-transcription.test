#!/usr/bin/env tclsh
# generated: 2026-07-23T15:39:59Z
package require tcltest
namespace import ::tcltest::*
source testHelpers.tcl

# Uncomment next line to view test durations.
#configure -verbose {body error usec}

############################################################
source "rna-transcription.tcl"


test rna-transcription-1 "Empty RNA sequence" -body {
    to-rna ""
} -returnCodes ok -result ""

skip rna-transcription-2
test rna-transcription-2 "RNA complement of cytosine is guanine" -body {
    to-rna "C"
} -returnCodes ok -result "G"

skip rna-transcription-3
test rna-transcription-3 "RNA complement of guanine is cytosine" -body {
    to-rna "G"
} -returnCodes ok -result "C"

skip rna-transcription-4
test rna-transcription-4 "RNA complement of thymine is adenine" -body {
    to-rna "T"
} -returnCodes ok -result "A"

skip rna-transcription-5
test rna-transcription-5 "RNA complement of adenine is uracil" -body {
    to-rna "A"
} -returnCodes ok -result "U"

skip rna-transcription-6
test rna-transcription-6 "RNA complement" -body {
    to-rna "ACGTGGTCTTAA"
} -returnCodes ok -result "UGCACCAGAAUU"


cleanupTests
