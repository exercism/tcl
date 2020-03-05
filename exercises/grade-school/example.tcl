proc roster {students} {
    set roster [dict create]

    # transform a list of {name grade} pairs into a dict of {grade names}
    foreach student $students {
        lassign $student name grade
        dict lappend roster $grade $name
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
