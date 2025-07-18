#!/usr/bin/env tclsh

# This script runs in the tcl-test-runner!
# The Tcl track is checked out into /opt/test-runner

package require json

proc run_tests {dir} {
    set slug [file tail $dir]

    puts -nonewline "Verifying $slug exercise... "

    cd $dir

    set f [open ./.meta/config.json r]
    set config [::json::json2dict [read $f]]
    close $f

    # if we get concept exercises, or if we get an exercise
    # with multiple solution files, revisit next 2 lines
    set example [dict get $config files example]
    set solution [dict get $config files solution]

    file copy -force $example $solution

    exec /opt/test-runner/bin/run.tcl $slug [pwd] [pwd]

    set f [open ./results.json r]
    set result [::json::json2dict [read $f]]
    close $f

    puts [dict get $result status]

    if {[dict get $result status] ne "pass"} {
        exec cat result.out
        exit 1
    }
}

############################################################
proc get_dirs {pr_number} {
    set url "https://api.github.com/repos/exercism/tcl/pulls/$pr_number/files"
    set json_string [exec wget --quiet --output-document=- $url]
    set file_info [::json::json2dict $json_string]

    set regex {(exercises/(?:concept|practice)/[^/]+)/.*(?:tcl|test)$}
    set exercise_dirs [lmap item $file_info {
        set filename [dict get $item filename]
        if {[regexp $regex $filename -> dir]} {
            string cat $dir
        } else continue
    }]

    lsort -unique $exercise_dirs
}

############################################################
proc verify_exercises {dirs} {
    if {[llength $dirs] == 0} {
        set dirs [glob exercises/practice/*]
    }
    foreach exercise_dir $dirs {
        run_tests $exercise_dir
    }
}

############################################################
lassign $argv pr_number

if {$pr_number eq ""} {
    verify_exercises {}
} else {
    verify_exercises [get_dirs $pr_number]
}
