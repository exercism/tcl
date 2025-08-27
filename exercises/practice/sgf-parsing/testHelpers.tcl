#############################################################
# Override some tcltest procs with additional functionality

# Allow an environment variable to override `skip`
proc skip {patternList} {
    if { [info exists ::env(RUN_ALL)]
         && [string is boolean -strict $::env(RUN_ALL)]
         && $::env(RUN_ALL)
    } then return else {
        uplevel 1 [list ::tcltest::skip $patternList]
    }
}

# Exit non-zero if any tests fail.
# The cleanupTests resets the numTests array, so capture it first.
proc cleanupTests {} {
    set failed [expr {$::tcltest::numTests(Failed) > 0}]
    uplevel 1 ::tcltest::cleanupTests
    if {$failed} then {exit 1}
}

#############################################################
# Some procs that are handy for Tcl test custom matching.

# Compare two SGF trees
proc sgfTreeMatch {expected actual} {
    if {
        ![string is dict -strict $actual]
        || [dict size $actual] != 2
        || [lsort [dict keys $actual]] ne {children properties}
    } {
        return false
    }

    # properties are equal
    if {[llength [dict get $actual properties]] != [llength [dict get $expected properties]]} {
        return false
    }
    dict for {name value} [dict get $expected properties] {
        if {![dict exists $actual properties $name]} {
            return false
        }
        if {![orderedListsMatch $value [dict get $actual properties $name]]} {
            return false
        }
    }

    # children are equal
    if {[llength [dict get $actual children]] != [llength [dict get $expected children]]} {
        return false
    }
    foreach actualChild [dict get $actual children] expectedChild [dict get $expected children] {
        if {![sgfTreeMatch $expectedChild $actualChild]} {
            return false
        }
    }

    return true
}
customMatch sgfTree sgfTreeMatch

# Compare two ordered lists without comparing the lists themselves 
# as strings.
# e.g.
#     set first {
#         a  b  c
#     }
#     set second [list a b c]
#     expr {$first eq $second}           ;# 0
#     expr {$first == $second}           ;# 0
#     orderedListsMatch $first $second   ;# true
#
proc orderedListsMatch {expected actual} {
    if {[llength $expected] != [llength $actual]} {
        return false
    }
    foreach e $expected a $actual {
        if {$e != $a} {
            return false
        }
    }
    return true
}
