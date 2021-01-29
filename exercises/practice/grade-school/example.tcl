proc roster {students} {
    set names [dict create]

    # transform a list of {name grade} pairs into a dict of {name grade}
    foreach student $students {
        lassign $student name grade
        dict lappend names $name $grade 
    }

    # ignoring students in multiple grades,
    # transpose into dict of {grade names}
    set roster [dict create]
    dict for {name grades} $names {
        if {[llength $grades] == 1} {
            dict lappend roster $grades $name
        }
    }

    # sort the names for each grade
    foreach grade [dict keys $roster] {
        dict update roster $grade names {
            set names [lsort $names]
        }
    }

    return [lsort -integer -stride 2 $roster]
}

proc grade {students grade} {
    set school [roster $students]
    try {
        return [dict get $school $grade]
    } on error {} {
        return {}
    }

    # Tcl 8.7 will have a `dict getwithdefault` command
    # https://tcl.tk/man/tcl8.7/TclCmd/dict.htm
}
