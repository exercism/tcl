#!/usr/bin/env tclsh
# generated: 2026-07-19T14:53:27Z
package require tcltest
namespace import ::tcltest::*
source testHelpers.tcl

# Uncomment next line to view test durations.
#configure -verbose {body error usec}

############################################################
source "piecing-it-together.tcl"


test piecing-it-together-1 "1000 pieces puzzle with 1.6 aspect ratio" -body {
    jigsawData {pieces 1000 aspectRatio 1.6}
} -returnCodes ok -match dictionary -result {
    pieces 1000
    border 126
    inside 874
    rows 25
    columns 40
    aspectRatio 1.6
    format landscape
}

skip piecing-it-together-2
test piecing-it-together-2 "square puzzle with 32 rows" -body {
    jigsawData {rows 32 format square}
} -returnCodes ok -match dictionary -result {
    pieces 1024
    border 124
    inside 900
    rows 32
    columns 32
    aspectRatio 1.0
    format square
}

skip piecing-it-together-3
test piecing-it-together-3 "400 pieces square puzzle with only inside pieces and aspect ratio" -body {
    jigsawData {inside 324 aspectRatio 1.0}
} -returnCodes ok -match dictionary -result {
    pieces 400
    border 76
    inside 324
    rows 20
    columns 20
    aspectRatio 1.0
    format square
}

skip piecing-it-together-4
test piecing-it-together-4 "1500 pieces landscape puzzle with 30 rows and 1.6 aspect ratio" -body {
    jigsawData {rows 30 aspectRatio 1.6666666666666667}
} -returnCodes ok -match dictionary -result {
    pieces 1500
    border 156
    inside 1344
    rows 30
    columns 50
    aspectRatio 1.6666666666666667
    format landscape
}

skip piecing-it-together-5
test piecing-it-together-5 "300 pieces portrait puzzle with 70 border pieces" -body {
    jigsawData {pieces 300 border 70 format portrait}
} -returnCodes ok -match dictionary -result {
    pieces 300
    border 70
    inside 230
    rows 25
    columns 12
    aspectRatio 0.48
    format portrait
}

skip piecing-it-together-6
test piecing-it-together-6 "puzzle with insufficient data" -body {
    jigsawData {pieces 1500 format landscape}
} -returnCodes error -result "Insufficient data"

skip piecing-it-together-7
test piecing-it-together-7 "puzzle with contradictory data" -body {
    jigsawData {rows 100 columns 1000 format square}
} -returnCodes error -result "Contradictory data"


cleanupTests
