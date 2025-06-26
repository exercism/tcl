namespace eval BottleSong {
    namespace export bottleSong

    variable numbers {No One Two Three Four Five Six Seven Eight Nine Ten}
    variable fall    {And if one green bottle should accidentally fall,}

    proc bottleSong {start take} {
        variable fall
        set lines {}
        set i $start
        while {$i >= $start - $take + 1} {
            set first [firstLine $i]
            incr i -1
            lappend lines "" $first $first $fall [secondLine $i]
        }
        return [lrange $lines 1 end]
    }

    proc firstLine {n} {
        return "[bottle $n] hanging on the wall,"
    }

    proc secondLine {m} {
        return "There'll be [string tolower [bottle $m]] hanging on the wall."
    }

    proc bottle {n} {
        variable numbers
        set num [lindex $numbers $n]
        set s [expr {$n == 1 ? "" : "s"}]
        return "$num green bottle$s"
    }
}

namespace import BottleSong::bottleSong
