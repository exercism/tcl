#!/usr/bin/env tclsh
set version 1.2.0.0
package require tcltest
namespace import ::tcltest::*
source "two-fer.tcl"

if {$::argv0 eq [info script]} {
    test two-fer {
        No name given

        Test [two-fer] == "One for you, one for me."

        It should be possible to call [two-fer] without arguments.
    } -body {two-fer} -result "One for you, one for me."
    test two-fer "A name given" -body {two-fer "Alice"} -result "One for Alice, one for me."
    test two-fer "Another name given" -body {two-fer "Bob"} -result "One for Bob, one for me."
    cleanupTests
}
