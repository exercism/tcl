#!/usr/bin/env tclsh
set version 1.1.0.0
package require tcltest
namespace import ::tcltest::*
source "hello-world.tcl"

if {$::argv0 eq [info script]} {
    test hello_Hello {
        Test: [hello] == "Hello, World!"
    } -body {
        hello
    } -result "Hello, World!"

    cleanupTests
}
