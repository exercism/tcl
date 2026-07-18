#!/usr/bin/env tclsh
# generated: 2026-07-18T01:58:37Z
package require tcltest
namespace import ::tcltest::*
source testHelpers.tcl

# Uncomment next line to view test durations.
#configure -verbose {body error usec}

############################################################
source "kindergarten-garden.tcl"


test kindergarten-garden-1 "partial garden: garden with single student" -body {
    plants "RC\nGG" Alice
} -returnCodes ok -result {radishes clover grass grass}

skip kindergarten-garden-2
test kindergarten-garden-2 "partial garden: different garden with single student" -body {
    plants "VC\nRC" Alice
} -returnCodes ok -result {violets clover radishes clover}

skip kindergarten-garden-3
test kindergarten-garden-3 "partial garden: garden with two students" -body {
    plants "VVCG\nVVRC" Bob
} -returnCodes ok -result {clover grass radishes clover}

skip kindergarten-garden-4
test kindergarten-garden-4 "partial garden: multiple students for the same garden with three students: second student's garden" -body {
    plants "VVCCGG\nVVCCGG" Bob
} -returnCodes ok -result {clover clover clover clover}

skip kindergarten-garden-5
test kindergarten-garden-5 "partial garden: multiple students for the same garden with three students: third student's garden" -body {
    plants "VVCCGG\nVVCCGG" Charlie
} -returnCodes ok -result {grass grass grass grass}

skip kindergarten-garden-6
test kindergarten-garden-6 "full garden: for Alice, first student's garden" -body {
    plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" Alice
} -returnCodes ok -result {violets radishes violets radishes}

skip kindergarten-garden-7
test kindergarten-garden-7 "full garden: for Bob, second student's garden" -body {
    plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" Bob
} -returnCodes ok -result {clover grass clover clover}

skip kindergarten-garden-8
test kindergarten-garden-8 "full garden: for Charlie" -body {
    plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" Charlie
} -returnCodes ok -result {violets violets clover grass}

skip kindergarten-garden-9
test kindergarten-garden-9 "full garden: for David" -body {
    plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" David
} -returnCodes ok -result {radishes violets clover radishes}

skip kindergarten-garden-10
test kindergarten-garden-10 "full garden: for Eve" -body {
    plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" Eve
} -returnCodes ok -result {clover grass radishes grass}

skip kindergarten-garden-11
test kindergarten-garden-11 "full garden: for Fred" -body {
    plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" Fred
} -returnCodes ok -result {grass clover violets clover}

skip kindergarten-garden-12
test kindergarten-garden-12 "full garden: for Ginny" -body {
    plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" Ginny
} -returnCodes ok -result {clover grass grass clover}

skip kindergarten-garden-13
test kindergarten-garden-13 "full garden: for Harriet" -body {
    plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" Harriet
} -returnCodes ok -result {violets radishes radishes violets}

skip kindergarten-garden-14
test kindergarten-garden-14 "full garden: for Ileana" -body {
    plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" Ileana
} -returnCodes ok -result {grass clover violets clover}

skip kindergarten-garden-15
test kindergarten-garden-15 "full garden: for Joseph" -body {
    plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" Joseph
} -returnCodes ok -result {violets clover violets grass}

skip kindergarten-garden-16
test kindergarten-garden-16 "full garden: for Kincaid, second to last student's garden" -body {
    plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" Kincaid
} -returnCodes ok -result {grass clover clover grass}

skip kindergarten-garden-17
test kindergarten-garden-17 "full garden: for Larry, last student's garden" -body {
    plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" Larry
} -returnCodes ok -result {grass violets clover violets}


cleanupTests
