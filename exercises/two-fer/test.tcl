#!/usr/bin/env tclsh
set version 1.2.0.0
package require tcltest
namespace import ::tcltest::*
source "two-fer.tcl"

if {$::argv0 eq [info script]} {

    test two-fer-1 {
        no name given
    } -body {
        two-fer
    } -result "One for you, one for me."

    test two-fer-2 {
        a name given
    } -body {
        two-fer "Alice"
    } -result "One for Alice, one for me."

    test two-fer-3 {
        another name given
    } -body {
        two-fer "Bob"
    } -result "One for Bob, one for me."

    cleanupTests
}
