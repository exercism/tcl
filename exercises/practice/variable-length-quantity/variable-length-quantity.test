#!/usr/bin/env tclsh
# generated: 2026-07-24T18:39:44Z
package require tcltest
namespace import ::tcltest::*
source testHelpers.tcl

# Uncomment next line to view test durations.
#configure -verbose {body error usec}

############################################################
source "variable-length-quantity.tcl"


test variable-length-quantity-1 "Encode a series of integers, producing a series of bytes.: zero" -body {
    encode {0x00}
} -returnCodes ok -match orderedLists -result {0x00}

skip variable-length-quantity-2
test variable-length-quantity-2 "Encode a series of integers, producing a series of bytes.: arbitrary single byte" -body {
    encode {0x40}
} -returnCodes ok -match orderedLists -result {0x40}

skip variable-length-quantity-3
test variable-length-quantity-3 "Encode a series of integers, producing a series of bytes.: asymmetric single byte" -body {
    encode {0x53}
} -returnCodes ok -match orderedLists -result {0x53}

skip variable-length-quantity-4
test variable-length-quantity-4 "Encode a series of integers, producing a series of bytes.: largest single byte" -body {
    encode {0x7f}
} -returnCodes ok -match orderedLists -result {0x7f}

skip variable-length-quantity-5
test variable-length-quantity-5 "Encode a series of integers, producing a series of bytes.: smallest double byte" -body {
    encode {0x80}
} -returnCodes ok -match orderedLists -result {0x81 0x00}

skip variable-length-quantity-6
test variable-length-quantity-6 "Encode a series of integers, producing a series of bytes.: arbitrary double byte" -body {
    encode {0x2000}
} -returnCodes ok -match orderedLists -result {0xc0 0x00}

skip variable-length-quantity-7
test variable-length-quantity-7 "Encode a series of integers, producing a series of bytes.: asymmetric double byte" -body {
    encode {0xad}
} -returnCodes ok -match orderedLists -result {0x81 0x2d}

skip variable-length-quantity-8
test variable-length-quantity-8 "Encode a series of integers, producing a series of bytes.: largest double byte" -body {
    encode {0x3fff}
} -returnCodes ok -match orderedLists -result {0xff 0x7f}

skip variable-length-quantity-9
test variable-length-quantity-9 "Encode a series of integers, producing a series of bytes.: smallest triple byte" -body {
    encode {0x4000}
} -returnCodes ok -match orderedLists -result {0x81 0x80 0x00}

skip variable-length-quantity-10
test variable-length-quantity-10 "Encode a series of integers, producing a series of bytes.: arbitrary triple byte" -body {
    encode {0x100000}
} -returnCodes ok -match orderedLists -result {0xc0 0x80 0x00}

skip variable-length-quantity-11
test variable-length-quantity-11 "Encode a series of integers, producing a series of bytes.: asymmetric triple byte" -body {
    encode {0x1d59c}
} -returnCodes ok -match orderedLists -result {0x87 0xab 0x1c}

skip variable-length-quantity-12
test variable-length-quantity-12 "Encode a series of integers, producing a series of bytes.: largest triple byte" -body {
    encode {0x1fffff}
} -returnCodes ok -match orderedLists -result {0xff 0xff 0x7f}

skip variable-length-quantity-13
test variable-length-quantity-13 "Encode a series of integers, producing a series of bytes.: smallest quadruple byte" -body {
    encode {0x200000}
} -returnCodes ok -match orderedLists -result {0x81 0x80 0x80 0x00}

skip variable-length-quantity-14
test variable-length-quantity-14 "Encode a series of integers, producing a series of bytes.: arbitrary quadruple byte" -body {
    encode {0x8000000}
} -returnCodes ok -match orderedLists -result {0xc0 0x80 0x80 0x00}

skip variable-length-quantity-15
test variable-length-quantity-15 "Encode a series of integers, producing a series of bytes.: asymmetric quadruple byte" -body {
    encode {0x357704}
} -returnCodes ok -match orderedLists -result {0x81 0xd5 0xee 0x04}

skip variable-length-quantity-16
test variable-length-quantity-16 "Encode a series of integers, producing a series of bytes.: largest quadruple byte" -body {
    encode {0xfffffff}
} -returnCodes ok -match orderedLists -result {0xff 0xff 0xff 0x7f}

skip variable-length-quantity-17
test variable-length-quantity-17 "Encode a series of integers, producing a series of bytes.: smallest quintuple byte" -body {
    encode {0x10000000}
} -returnCodes ok -match orderedLists -result {0x81 0x80 0x80 0x80 0x00}

skip variable-length-quantity-18
test variable-length-quantity-18 "Encode a series of integers, producing a series of bytes.: arbitrary quintuple byte" -body {
    encode {0xff000000}
} -returnCodes ok -match orderedLists -result {0x8f 0xf8 0x80 0x80 0x00}

skip variable-length-quantity-19
test variable-length-quantity-19 "Encode a series of integers, producing a series of bytes.: asymmetric quintuple byte" -body {
    encode {0x86656105}
} -returnCodes ok -match orderedLists -result {0x88 0xb3 0x95 0xc2 0x05}

skip variable-length-quantity-20
test variable-length-quantity-20 "Encode a series of integers, producing a series of bytes.: maximum 32-bit integer input" -body {
    encode {0xffffffff}
} -returnCodes ok -match orderedLists -result {0x8f 0xff 0xff 0xff 0x7f}

skip variable-length-quantity-21
test variable-length-quantity-21 "Encode a series of integers, producing a series of bytes.: two single-byte values" -body {
    encode {0x40 0x7f}
} -returnCodes ok -match orderedLists -result {0x40 0x7f}

skip variable-length-quantity-22
test variable-length-quantity-22 "Encode a series of integers, producing a series of bytes.: two multi-byte values" -body {
    encode {0x4000 0x123456}
} -returnCodes ok -match orderedLists -result {0x81 0x80 0x00 0xc8 0xe8 0x56}

skip variable-length-quantity-23
test variable-length-quantity-23 "Encode a series of integers, producing a series of bytes.: many multi-byte values" -body {
    encode {0x2000 0x123456 0xfffffff 0x00 0x3fff 0x4000}
} -returnCodes ok -match orderedLists -result {0xc0 0x00 0xc8 0xe8 0x56 0xff 0xff 0xff 0x7f 0x00 0xff 0x7f 0x81 0x80 0x00}

skip variable-length-quantity-24
test variable-length-quantity-24 "Decode a series of bytes, producing a series of integers.: one byte" -body {
    decode {0x7f}
} -returnCodes ok -match orderedLists -result {0x7f}

skip variable-length-quantity-25
test variable-length-quantity-25 "Decode a series of bytes, producing a series of integers.: two bytes" -body {
    decode {0xc0 0x00}
} -returnCodes ok -match orderedLists -result {0x2000}

skip variable-length-quantity-26
test variable-length-quantity-26 "Decode a series of bytes, producing a series of integers.: three bytes" -body {
    decode {0xff 0xff 0x7f}
} -returnCodes ok -match orderedLists -result {0x1fffff}

skip variable-length-quantity-27
test variable-length-quantity-27 "Decode a series of bytes, producing a series of integers.: four bytes" -body {
    decode {0x81 0x80 0x80 0x00}
} -returnCodes ok -match orderedLists -result {0x200000}

skip variable-length-quantity-28
test variable-length-quantity-28 "Decode a series of bytes, producing a series of integers.: maximum 32-bit integer" -body {
    decode {0x8f 0xff 0xff 0xff 0x7f}
} -returnCodes ok -match orderedLists -result {0xffffffff}

skip variable-length-quantity-29
test variable-length-quantity-29 "Decode a series of bytes, producing a series of integers.: incomplete sequence causes error" -body {
    decode {0xff}
} -returnCodes error -result "incomplete sequence"

skip variable-length-quantity-30
test variable-length-quantity-30 "Decode a series of bytes, producing a series of integers.: incomplete sequence causes error, even if value is zero" -body {
    decode {0x80}
} -returnCodes error -result "incomplete sequence"

skip variable-length-quantity-31
test variable-length-quantity-31 "Decode a series of bytes, producing a series of integers.: multiple values" -body {
    decode {0xc0 0x00 0xc8 0xe8 0x56 0xff 0xff 0xff 0x7f 0x00 0xff 0x7f 0x81 0x80 0x00}
} -returnCodes ok -match orderedLists -result {0x2000 0x123456 0xfffffff 0x00 0x3fff 0x4000}


cleanupTests
