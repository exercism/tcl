#!/usr/bin/env tclsh
set version 1.1.0.0
package require tcltest
namespace import ::tcltest::*
source "hello-world.tcl"

test hello_Hello {
    Test: [hello] == "Hello, World!"
} -body {
    hello
} -result "Hello, World!"

cleanupTests
