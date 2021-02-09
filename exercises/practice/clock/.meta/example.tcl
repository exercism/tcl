oo::class create Clock {
    variable time

    constructor {hour minute} {
        set time [expr {60 * $hour + $minute}]
        my _normalize
    }

    # ensure the time is between 00:00 and 23:59
    method _normalize {} {
        set time [expr {$time % (24 * 60)}]
        return
    }

    method time {} {
        return $time
    }

    method toString {} {
        return [format "%02d:%02d" [expr {$time / 60}] [expr {$time % 60}]]
    }

    method add {minutes} {
        incr time $minutes
        my _normalize
        return [self]
    }

    method subtract {minutes} {
        return [my add [expr {-1 * $minutes}]]
    }

    method equals {other} {
        return [expr {[my time] eq [$other time]}]
    }

    # "alias" a method.
    # Only methods named [a-z]* are auto-exported

    forward ==  my equals
    export  ==
}
