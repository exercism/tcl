#!/usr/bin/env tclsh
# generated: 2026-07-23T12:29:50Z
package require tcltest
namespace import ::tcltest::*
source testHelpers.tcl

# Uncomment next line to view test durations.
#configure -verbose {body error usec}

############################################################
source "rational-numbers.tcl"


test rational-numbers-1 "Arithmetic: Addition: Add two positive rational numbers" -body {
    set r1 [Rational new 1 2]
    set r2 [Rational new 2 3]
    [$r1 add $r2] toString
} -returnCodes ok -result "7/6"


skip rational-numbers-2
test rational-numbers-2 "Arithmetic: Addition: Add a positive rational number and a negative rational number" -body {
    set r1 [Rational new 1 2]
    set r2 [Rational new -2 3]
    [$r1 add $r2] toString
} -returnCodes ok -result "-1/6"


skip rational-numbers-3
test rational-numbers-3 "Arithmetic: Addition: Add two negative rational numbers" -body {
    set r1 [Rational new -1 2]
    set r2 [Rational new -2 3]
    [$r1 add $r2] toString
} -returnCodes ok -result "-7/6"


skip rational-numbers-4
test rational-numbers-4 "Arithmetic: Addition: Add a rational number to its additive inverse" -body {
    set r1 [Rational new 1 2]
    set r2 [Rational new -1 2]
    [$r1 add $r2] toString
} -returnCodes ok -result "0/1"


skip rational-numbers-5
test rational-numbers-5 "Arithmetic: Subtraction: Subtract two positive rational numbers" -body {
    set r1 [Rational new 1 2]
    set r2 [Rational new 2 3]
    [$r1 sub $r2] toString
} -returnCodes ok -result "-1/6"


skip rational-numbers-6
test rational-numbers-6 "Arithmetic: Subtraction: Subtract a positive rational number and a negative rational number" -body {
    set r1 [Rational new 1 2]
    set r2 [Rational new -2 3]
    [$r1 sub $r2] toString
} -returnCodes ok -result "7/6"


skip rational-numbers-7
test rational-numbers-7 "Arithmetic: Subtraction: Subtract two negative rational numbers" -body {
    set r1 [Rational new -1 2]
    set r2 [Rational new -2 3]
    [$r1 sub $r2] toString
} -returnCodes ok -result "1/6"


skip rational-numbers-8
test rational-numbers-8 "Arithmetic: Subtraction: Subtract a rational number from itself" -body {
    set r1 [Rational new 1 2]
    set r2 [Rational new 1 2]
    [$r1 sub $r2] toString
} -returnCodes ok -result "0/1"


skip rational-numbers-9
test rational-numbers-9 "Arithmetic: Multiplication: Multiply two positive rational numbers" -body {
    set r1 [Rational new 1 2]
    set r2 [Rational new 2 3]
    [$r1 mul $r2] toString
} -returnCodes ok -result "1/3"


skip rational-numbers-10
test rational-numbers-10 "Arithmetic: Multiplication: Multiply a negative rational number by a positive rational number" -body {
    set r1 [Rational new -1 2]
    set r2 [Rational new 2 3]
    [$r1 mul $r2] toString
} -returnCodes ok -result "-1/3"


skip rational-numbers-11
test rational-numbers-11 "Arithmetic: Multiplication: Multiply two negative rational numbers" -body {
    set r1 [Rational new -1 2]
    set r2 [Rational new -2 3]
    [$r1 mul $r2] toString
} -returnCodes ok -result "1/3"


skip rational-numbers-12
test rational-numbers-12 "Arithmetic: Multiplication: Multiply a rational number by its reciprocal" -body {
    set r1 [Rational new 1 2]
    set r2 [Rational new 2 1]
    [$r1 mul $r2] toString
} -returnCodes ok -result "1/1"


skip rational-numbers-13
test rational-numbers-13 "Arithmetic: Multiplication: Multiply a rational number by 1" -body {
    set r1 [Rational new 1 2]
    set r2 [Rational new 1 1]
    [$r1 mul $r2] toString
} -returnCodes ok -result "1/2"


skip rational-numbers-14
test rational-numbers-14 "Arithmetic: Multiplication: Multiply a rational number by 0" -body {
    set r1 [Rational new 1 2]
    set r2 [Rational new 0 1]
    [$r1 mul $r2] toString
} -returnCodes ok -result "0/1"


skip rational-numbers-15
test rational-numbers-15 "Arithmetic: Division: Divide two positive rational numbers" -body {
    set r1 [Rational new 1 2]
    set r2 [Rational new 2 3]
    [$r1 div $r2] toString
} -returnCodes ok -result "3/4"


skip rational-numbers-16
test rational-numbers-16 "Arithmetic: Division: Divide a positive rational number by a negative rational number" -body {
    set r1 [Rational new 1 2]
    set r2 [Rational new -2 3]
    [$r1 div $r2] toString
} -returnCodes ok -result "-3/4"


skip rational-numbers-17
test rational-numbers-17 "Arithmetic: Division: Divide two negative rational numbers" -body {
    set r1 [Rational new -1 2]
    set r2 [Rational new -2 3]
    [$r1 div $r2] toString
} -returnCodes ok -result "3/4"


skip rational-numbers-18
test rational-numbers-18 "Arithmetic: Division: Divide a rational number by 1" -body {
    set r1 [Rational new 1 2]
    set r2 [Rational new 1 1]
    [$r1 div $r2] toString
} -returnCodes ok -result "1/2"


skip rational-numbers-19
test rational-numbers-19 "Absolute value: Absolute value of a positive rational number" -body {
    set r [Rational new 1 2]
    [$r abs] toString
} -returnCodes ok -result "1/2"

skip rational-numbers-20
test rational-numbers-20 "Absolute value: Absolute value of a positive rational number with negative numerator and denominator" -body {
    set r [Rational new -1 -2]
    [$r abs] toString
} -returnCodes ok -result "1/2"

skip rational-numbers-21
test rational-numbers-21 "Absolute value: Absolute value of a negative rational number" -body {
    set r [Rational new -1 2]
    [$r abs] toString
} -returnCodes ok -result "1/2"

skip rational-numbers-22
test rational-numbers-22 "Absolute value: Absolute value of a negative rational number with negative denominator" -body {
    set r [Rational new 1 -2]
    [$r abs] toString
} -returnCodes ok -result "1/2"

skip rational-numbers-23
test rational-numbers-23 "Absolute value: Absolute value of zero" -body {
    set r [Rational new 0 1]
    [$r abs] toString
} -returnCodes ok -result "0/1"

skip rational-numbers-24
test rational-numbers-24 "Absolute value: Absolute value of a rational number is reduced to lowest terms" -body {
    set r [Rational new 2 4]
    [$r abs] toString
} -returnCodes ok -result "1/2"

skip rational-numbers-25
test rational-numbers-25 "Exponentiation of a rational number: Raise a positive rational number to a positive integer power" -body {
    set r [Rational new 1 2]
    [$r pow 3] toString
} -returnCodes ok -result "1/8"

skip rational-numbers-26
test rational-numbers-26 "Exponentiation of a rational number: Raise a negative rational number to a positive integer power" -body {
    set r [Rational new -1 2]
    [$r pow 3] toString
} -returnCodes ok -result "-1/8"

skip rational-numbers-27
test rational-numbers-27 "Exponentiation of a rational number: Raise a positive rational number to a negative integer power" -body {
    set r [Rational new 3 5]
    [$r pow -2] toString
} -returnCodes ok -result "25/9"

skip rational-numbers-28
test rational-numbers-28 "Exponentiation of a rational number: Raise a negative rational number to an even negative integer power" -body {
    set r [Rational new -3 5]
    [$r pow -2] toString
} -returnCodes ok -result "25/9"

skip rational-numbers-29
test rational-numbers-29 "Exponentiation of a rational number: Raise a negative rational number to an odd negative integer power" -body {
    set r [Rational new -3 5]
    [$r pow -3] toString
} -returnCodes ok -result "-125/27"

skip rational-numbers-30
test rational-numbers-30 "Exponentiation of a rational number: Raise zero to an integer power" -body {
    set r [Rational new 0 1]
    [$r pow 5] toString
} -returnCodes ok -result "0/1"

skip rational-numbers-31
test rational-numbers-31 "Exponentiation of a rational number: Raise one to an integer power" -body {
    set r [Rational new 1 1]
    [$r pow 4] toString
} -returnCodes ok -result "1/1"

skip rational-numbers-32
test rational-numbers-32 "Exponentiation of a rational number: Raise a positive rational number to the power of zero" -body {
    set r [Rational new 1 2]
    [$r pow 0] toString
} -returnCodes ok -result "1/1"

skip rational-numbers-33
test rational-numbers-33 "Exponentiation of a rational number: Raise a negative rational number to the power of zero" -body {
    set r [Rational new -1 2]
    [$r pow 0] toString
} -returnCodes ok -result "1/1"

skip rational-numbers-34
test rational-numbers-34 "Exponentiation of a real number to a rational number: Raise a real number to a positive rational number" -body {
    set r [Rational new 4 3]
    $r exprational 8
} -returnCodes ok -match double -result 16.0

skip rational-numbers-35
test rational-numbers-35 "Exponentiation of a real number to a rational number: Raise a real number to a negative rational number" -body {
    set r [Rational new -1 2]
    $r exprational 9
} -returnCodes ok -match double -result 0.3333333333333333

skip rational-numbers-36
test rational-numbers-36 "Exponentiation of a real number to a rational number: Raise a real number to a zero rational number" -body {
    set r [Rational new 0 1]
    $r exprational 2
} -returnCodes ok -match double -result 1.0

skip rational-numbers-37
test rational-numbers-37 "Reduction to lowest terms: Reduce a positive rational number to lowest terms" -body {
    set r [Rational new 2 4]
    $r toString
} -returnCodes ok -result "1/2"

skip rational-numbers-38
test rational-numbers-38 "Reduction to lowest terms: Reduce places the minus sign on the numerator" -body {
    set r [Rational new 3 -4]
    $r toString
} -returnCodes ok -result "-3/4"

skip rational-numbers-39
test rational-numbers-39 "Reduction to lowest terms: Reduce a negative rational number to lowest terms" -body {
    set r [Rational new -4 6]
    $r toString
} -returnCodes ok -result "-2/3"

skip rational-numbers-40
test rational-numbers-40 "Reduction to lowest terms: Reduce a rational number with a negative denominator to lowest terms" -body {
    set r [Rational new 3 -9]
    $r toString
} -returnCodes ok -result "-1/3"

skip rational-numbers-41
test rational-numbers-41 "Reduction to lowest terms: Reduce zero to lowest terms" -body {
    set r [Rational new 0 6]
    $r toString
} -returnCodes ok -result "0/1"

skip rational-numbers-42
test rational-numbers-42 "Reduction to lowest terms: Reduce an integer to lowest terms" -body {
    set r [Rational new -14 7]
    $r toString
} -returnCodes ok -result "-2/1"

skip rational-numbers-43
test rational-numbers-43 "Reduction to lowest terms: Reduce one to lowest terms" -body {
    set r [Rational new 13 13]
    $r toString
} -returnCodes ok -result "1/1"


cleanupTests
