#!/usr/bin/env tclsh
set version 1.1.0.0
package require tcltest
namespace import ::tcltest::*
source "hello-world.tcl"

proc fail_fast {} {
    return [expr {
        ![info exists ::env(RUN_ALL)]
        || [string is boolean -strict $::env(RUN_ALL)]
        && !$::env(RUN_ALL)
    }]
}

if {[fail_fast]} {
    proc test args {
        if {$::tcltest::numTests(Failed) > 0} {
            ::tcltest::configure -skip *
        }
        uplevel [list ::tcltest::test {*}$args]
    }
}

if {$::argv0 eq [info script]} {
    test hello_Hello {
        Test: [hello] == "Hello, World!"
    } -body {
        hello
    } -result "Hello, World!"

    cleanupTests
}
