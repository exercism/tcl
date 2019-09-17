oo::class create Clock {
    constructor {hour minute} {
        variable time
        set time [expr {60 * $hour + $minute}]
        my _normalize
    }

    # ensure the time is between 00:00 and 23:59
    method _normalize {} {
        my variable time
        set time [expr {$time % (24 * 60)}]
        return
    }

    method time {} {
        my variable time
        return $time
    }

    method toString {} {
        my variable time
        return [format "%02d:%02d" [expr {$time / 60}] [expr {$time % 60}]]
    }

    method add {minutes} {
        my variable time
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
