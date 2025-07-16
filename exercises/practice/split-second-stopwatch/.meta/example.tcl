oo::class create Stopwatch {
    variable state
    variable started
    variable stopped
    variable durations
    variable laps

    constructor {} {
        my reset
    }

    method reset {} {
        if {[info exists state] && $state in {ready running}} {
            error "cannot reset a stopwatch that is not stopped"
        }
        set state ready
        set durations {running {} lap {}}
        set laps {}
    }

    method state {} {
        return $state
    }

    method previousLaps {} {
        return $laps
    }

    method start {} {
        if {$state eq "running"} {
            error "cannot start an already running stopwatch"
        }
        set started [clock seconds]
        set state running
    }

    method stop {} {
        if {$state ne "running"} {
            error "cannot stop a stopwatch that is not running"
        }

        set state stopped
        set stopped [clock seconds]
        dict lappend durations lap [expr {$stopped - $started}]
    }

    method lap {} {
        if {$state ne "running"} {
            error "cannot lap a stopwatch that is not running"
        }

        my stop
        my start

        lappend laps [my currentLap]
        dict lappend durations running {*}[dict get $durations lap]
        dict set durations lap {}
    }

    method currentLap {} {
        my FormatDuration [::tcl::mathop::+ [my CurrentDuration] {*}[dict get $durations lap]]
    }

    method total {} {
        my FormatDuration [::tcl::mathop::+ \
            [my CurrentDuration] \
            {*}[dict get $durations lap] \
            {*}[dict get $durations running] \
        ]
    }

    method CurrentDuration {} {
        expr {$state eq "running" ? [clock seconds] - $started : 0}
    }

    method FormatDuration {duration} {
        format {%02d:%02d:%02d} \
            [expr {$duration / 3600}] \
            [expr {$duration / 60 % 60}] \
            [expr {$duration % 60}]
    }
}
