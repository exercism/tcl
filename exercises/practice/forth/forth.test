#!/usr/bin/env tclsh
# generated: 2026-07-17T23:24:20Z
package require tcltest
namespace import ::tcltest::*
source testHelpers.tcl

# Uncomment next line to view test durations.
#configure -verbose {body error usec}

############################################################
source "forth.tcl"


test forth-1 "parsing and numbers: numbers just get pushed onto the stack" -body {
    evalForth "1 2 3 4 5"
} -returnCodes ok -result {1 2 3 4 5}

skip forth-2
test forth-2 "parsing and numbers: pushes negative numbers onto the stack" -body {
    evalForth "-1 -2 -3 -4 -5"
} -returnCodes ok -result {-1 -2 -3 -4 -5}

skip forth-3
test forth-3 "addition: can add two numbers" -body {
    evalForth "1 2 +"
} -returnCodes ok -result {3}

skip forth-4
test forth-4 "addition: errors if there is nothing on the stack" -body {
    evalForth "+"
} -returnCodes error -result "empty stack"

skip forth-5
test forth-5 "addition: errors if there is only one value on the stack" -body {
    evalForth "1 +"
} -returnCodes error -result "only one value on the stack"

skip forth-6
test forth-6 "addition: more than two values on the stack" -body {
    evalForth "1 2 3 +"
} -returnCodes ok -result {1 5}

skip forth-7
test forth-7 "subtraction: can subtract two numbers" -body {
    evalForth "3 4 -"
} -returnCodes ok -result {-1}

skip forth-8
test forth-8 "subtraction: errors if there is nothing on the stack" -body {
    evalForth "-"
} -returnCodes error -result "empty stack"

skip forth-9
test forth-9 "subtraction: errors if there is only one value on the stack" -body {
    evalForth "1 -"
} -returnCodes error -result "only one value on the stack"

skip forth-10
test forth-10 "subtraction: more than two values on the stack" -body {
    evalForth "1 12 3 -"
} -returnCodes ok -result {1 9}

skip forth-11
test forth-11 "multiplication: can multiply two numbers" -body {
    evalForth "2 4 *"
} -returnCodes ok -result {8}

skip forth-12
test forth-12 "multiplication: errors if there is nothing on the stack" -body {
    evalForth "*"
} -returnCodes error -result "empty stack"

skip forth-13
test forth-13 "multiplication: errors if there is only one value on the stack" -body {
    evalForth "1 *"
} -returnCodes error -result "only one value on the stack"

skip forth-14
test forth-14 "multiplication: more than two values on the stack" -body {
    evalForth "1 2 3 *"
} -returnCodes ok -result {1 6}

skip forth-15
test forth-15 "division: can divide two numbers" -body {
    evalForth "12 3 /"
} -returnCodes ok -result {4}

skip forth-16
test forth-16 "division: performs integer division" -body {
    evalForth "8 3 /"
} -returnCodes ok -result {2}

skip forth-17
test forth-17 "division: errors if dividing by zero" -body {
    evalForth "4 0 /"
} -returnCodes error -result "divide by zero"

skip forth-18
test forth-18 "division: errors if there is nothing on the stack" -body {
    evalForth "/"
} -returnCodes error -result "empty stack"

skip forth-19
test forth-19 "division: errors if there is only one value on the stack" -body {
    evalForth "1 /"
} -returnCodes error -result "only one value on the stack"

skip forth-20
test forth-20 "division: more than two values on the stack" -body {
    evalForth "1 12 3 /"
} -returnCodes ok -result {1 4}

skip forth-21
test forth-21 "combined arithmetic: addition and subtraction" -body {
    evalForth "1 2 + 4 -"
} -returnCodes ok -result {-1}

skip forth-22
test forth-22 "combined arithmetic: multiplication and division" -body {
    evalForth "2 4 * 3 /"
} -returnCodes ok -result {2}

skip forth-23
test forth-23 "combined arithmetic: multiplication and addition" -body {
    evalForth "1 3 4 * +"
} -returnCodes ok -result {13}

skip forth-24
test forth-24 "combined arithmetic: addition and multiplication" -body {
    evalForth "1 3 4 + *"
} -returnCodes ok -result {7}

skip forth-25
test forth-25 "dup: copies a value on the stack" -body {
    evalForth "1 dup"
} -returnCodes ok -result {1 1}

skip forth-26
test forth-26 "dup: copies the top value on the stack" -body {
    evalForth "1 2 dup"
} -returnCodes ok -result {1 2 2}

skip forth-27
test forth-27 "dup: errors if there is nothing on the stack" -body {
    evalForth "dup"
} -returnCodes error -result "empty stack"

skip forth-28
test forth-28 "drop: removes the top value on the stack if it is the only one" -body {
    evalForth "1 drop"
} -returnCodes ok -result {}

skip forth-29
test forth-29 "drop: removes the top value on the stack if it is not the only one" -body {
    evalForth "1 2 drop"
} -returnCodes ok -result {1}

skip forth-30
test forth-30 "drop: errors if there is nothing on the stack" -body {
    evalForth "drop"
} -returnCodes error -result "empty stack"

skip forth-31
test forth-31 "swap: swaps the top two values on the stack if they are the only ones" -body {
    evalForth "1 2 swap"
} -returnCodes ok -result {2 1}

skip forth-32
test forth-32 "swap: swaps the top two values on the stack if they are not the only ones" -body {
    evalForth "1 2 3 swap"
} -returnCodes ok -result {1 3 2}

skip forth-33
test forth-33 "swap: errors if there is nothing on the stack" -body {
    evalForth "swap"
} -returnCodes error -result "empty stack"

skip forth-34
test forth-34 "swap: errors if there is only one value on the stack" -body {
    evalForth "1 swap"
} -returnCodes error -result "only one value on the stack"

skip forth-35
test forth-35 "over: copies the second element if there are only two" -body {
    evalForth "1 2 over"
} -returnCodes ok -result {1 2 1}

skip forth-36
test forth-36 "over: copies the second element if there are more than two" -body {
    evalForth "1 2 3 over"
} -returnCodes ok -result {1 2 3 2}

skip forth-37
test forth-37 "over: errors if there is nothing on the stack" -body {
    evalForth "over"
} -returnCodes error -result "empty stack"

skip forth-38
test forth-38 "over: errors if there is only one value on the stack" -body {
    evalForth "1 over"
} -returnCodes error -result "only one value on the stack"

skip forth-39
test forth-39 "user-defined words: can consist of built-in words" -body {
    evalForth ": dup-twice dup dup ;\n1 dup-twice"
} -returnCodes ok -result {1 1 1}

skip forth-40
test forth-40 "user-defined words: execute in the right order" -body {
    evalForth ": countup 1 2 3 ;\ncountup"
} -returnCodes ok -result {1 2 3}

skip forth-41
test forth-41 "user-defined words: can override other user-defined words" -body {
    evalForth ": foo dup ;\n: foo dup dup ;\n1 foo"
} -returnCodes ok -result {1 1 1}

skip forth-42
test forth-42 "user-defined words: can override built-in words" -body {
    evalForth ": swap dup ;\n1 swap"
} -returnCodes ok -result {1 1}

skip forth-43
test forth-43 "user-defined words: can override built-in operators" -body {
    evalForth ": + * ;\n3 4 +"
} -returnCodes ok -result {12}

skip forth-44
test forth-44 "user-defined words: can use different words with the same name" -body {
    evalForth ": foo 5 ;\n: bar foo ;\n: foo 6 ;\nbar foo"
} -returnCodes ok -result {5 6}

skip forth-45
test forth-45 "user-defined words: can define word that uses word with the same name" -body {
    evalForth ": foo 10 ;\n: foo foo 1 + ;\nfoo"
} -returnCodes ok -result {11}

skip forth-46
test forth-46 "user-defined words: cannot redefine non-negative numbers" -body {
    evalForth ": 1 2 ;"
} -returnCodes error -result "illegal operation"

skip forth-47
test forth-47 "user-defined words: cannot redefine negative numbers" -body {
    evalForth ": -1 2 ;"
} -returnCodes error -result "illegal operation"

skip forth-48
test forth-48 "user-defined words: errors if executing a non-existent word" -body {
    evalForth "foo"
} -returnCodes error -result "undefined operation"

skip forth-49
test forth-49 "case-insensitivity: DUP is case-insensitive" -body {
    evalForth "1 DUP Dup dup"
} -returnCodes ok -result {1 1 1 1}

skip forth-50
test forth-50 "case-insensitivity: DROP is case-insensitive" -body {
    evalForth "1 2 3 4 DROP Drop drop"
} -returnCodes ok -result {1}

skip forth-51
test forth-51 "case-insensitivity: SWAP is case-insensitive" -body {
    evalForth "1 2 SWAP 3 Swap 4 swap"
} -returnCodes ok -result {2 3 4 1}

skip forth-52
test forth-52 "case-insensitivity: OVER is case-insensitive" -body {
    evalForth "1 2 OVER Over over"
} -returnCodes ok -result {1 2 1 2 1}

skip forth-53
test forth-53 "case-insensitivity: user-defined words are case-insensitive" -body {
    evalForth ": foo dup ;\n1 FOO Foo foo"
} -returnCodes ok -result {1 1 1 1}

skip forth-54
test forth-54 "case-insensitivity: definitions are case-insensitive" -body {
    evalForth ": SWAP DUP Dup dup ;\n1 swap"
} -returnCodes ok -result {1 1 1 1}

# If you chose an OO or namespace approach to this, change
# "false" to "true".
# Update the test case to suit your solution's class/namespace/method names.
if false {
    test forth-extra-1 "only defines locally" -body {
        set f1 [Forth new]
        set f2 [Forth new]

        set result1 [$f1 evaluate ": + - ;\n1 1 +"]
        set result2 [$f2 evaluate "1 1 +"]

        list $result1 $result2
    } -returnCodes ok -result {0 2}
}

cleanupTests
