namespace eval school {
    namespace export reset add grade roster
    namespace ensemble create

    variable classes

    proc reset {} {
        variable classes
        set classes {}
    }

    proc add {students} {
        variable classes
        return [lmap student $students {
            lassign $student name grade
            if {$name in [roster]} {
                string cat "false"
            } else {
                dict lappend classes $grade $name
                string cat "true"
            }
        }]
    }

    proc grade {desiredGrade} {
        variable classes
        return [try {
            lsort [dict get $classes $desiredGrade]
        } on error {} {
            list
        }]
    }

    proc roster {} {
        variable classes
        set roster {}
        foreach grade [lsort -integer [dict keys $classes]] {
            lappend roster {*}[grade $grade]
        }
        return $roster
    }
}
