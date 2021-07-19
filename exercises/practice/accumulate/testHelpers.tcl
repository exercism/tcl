#############################################################
# Override some tcltest procs with additional functionality

# allow an environment variable to override `skip`
proc skip {args} {
    if {!([info exists ::env(RUN_ALL)] && $::env(RUN_ALL))} {
        uplevel 1 [list ::tcltest::skip {*}$args]
    }
}

proc cleanupTests {} {
    set failed [expr {$::tcltest::numTests(Failed) > 0}]
    uplevel 1 ::tcltest::cleanupTests
    if {$failed} then {exit 1}
}
