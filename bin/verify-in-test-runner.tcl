#!/usr/bin/env tclsh

# This script runs in the tcl-test-runner!
# The Tcl track is checked out into /opt/test-runner

package require json

# Synopsis:
# Verify that each exercise's example/exemplar solution passes the tests
# using the track's test runner Docker image.
# You can either verify all exercises or a single exercise.

# Example: verify all exercises in Docker
# bin/verify-exercises-in-docker.tcl

# Example: verify specific exercises in Docker
# bin/verify-exercises-in-docker.tcl two-fer leap reverse-string


proc run_tests {directory} {
    set dir [file dirname $directory]
    set slug [file tail $directory]

    puts -nonewline "Verifying $slug exercise... "

    cd $dir

    set f [open ./.meta/config.json r]
    set config [json::json2dict [read $f]]
    close $f

    # if we get concept exercises, or if we get an exercise
    # with multiple solution files, revisit next 2 lines
    set example [dict get $config files example]
    set solution [dict get $config files solution]

    file copy --force $example $solution

    exec /opt/test-runner/bin/run.tcl $slug [pwd] [pwd]

    set f [open ./results.json r]
    set result [json::json2dict [read $f]]
    close $f

    puts [dict get $result status]

    if {[dict get $result status] ne "pass"} {
        exec cat result.out
        exit 1
    }
}

proc verify_exercises {slugs} {
    if {[llength $slugs] == 0} {
        set dirs [glob ./exercises/practice/*]
    } else {
        set dirs [lmap slug $slugs {
            set dir "./exercises/practice/$slug"
            expr {[file isdirectory $dir] ? $dir : [continue]}
        }
    }

    if {[llength $dirs] == 0} {
        error "no matching exercises found!"
    }

    foreach exercise_dir $dirs {
        run_tests $exercise_dir
    }
}

verify_exercises $argv
