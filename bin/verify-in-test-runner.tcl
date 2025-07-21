#!/usr/bin/env tclsh

# This script runs in the tcl-test-runner!

package require json

############################################################
proc run_tests {dir} {
    set slug [file tail $dir]
    puts -nonewline "$slug ... "

    prepare_exercise $dir

    exec /opt/test-runner/bin/run.tcl $slug $dir $dir

    lassign [get_test_status $dir] status output
    puts $status

    if {$status eq "pass"} {
        puts "    [lindex [split [string trim $output] \n] end]"
    } else {
        puts "******"
        puts $output
        exit 1
    }
}

proc prepare_exercise {dir} {
    set cwd [pwd]
    cd $dir

    set fh [open ./.meta/config.json r]
    set config [::json::json2dict [read $fh]]
    close $fh

    # if we get concept exercises, or if we get an exercise
    # with multiple solution files, revisit next 2 lines
    set example [dict get $config files example]
    set solution [dict get $config files solution]

    file copy -force $example $solution
    cd $cwd
}

proc get_test_status {dir} {
    set fh [open $dir/results.json r]
    set result [::json::json2dict [read $fh]]
    close $fh

    set fh [open $dir/results.out r]
    set output [read $fh]
    close $fh

    list [dict get $result status] $output
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
proc main {argc argv} {
    set start [clock seconds]

    if {$argc == 0} {
        # CI -- test all exercises
        set dirs [glob exercises/practice/*]
    } else {
        # PR -- first argument is PR number
        set dirs [get_dirs [lindex $argv 0]]
    }

    foreach dir [lsort $dirs] {
        run_tests $dir
    }

    set duration [expr {[clock seconds] - $start}]
    puts "\n[llength $dirs] exercises verified in $duration seconds."
}

main $argc $argv
