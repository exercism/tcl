#!/usr/bin/env tclsh
set version 1.1.0.0
package require tcltest
namespace import ::tcltest::*
source "hello-world.tcl"

proc test args {
    if {$::tcltest::numTests(Failed) > 0} {
        puts "**** Exit on first failure"
        exit 1
    }
    uplevel [list ::tcltest::test {*}$args]
}

if {$::argv0 eq [info script]} {
    test hello_Hello {
        Test: [hello] == "Hello, World!"
    } -body {
        hello
    } -result "Hello, World!"

    cleanupTests
}
