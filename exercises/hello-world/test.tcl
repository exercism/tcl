#!/usr/bin/env tclsh
set version 1.1.0.0
package require tcltest
namespace import ::tcltest::*
source "hello-world.tcl"

if {$::argv0 eq [info script]} {

    test hello-1 {
        Say Hi!
    } -body {
        hello
    } -result "Hello, World!"

    cleanupTests
}
