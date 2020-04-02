namespace eval JacksHouse {
    namespace export recite

    variable items {
        {"house that Jack built"            ""}
        {"malt"                             "lay in"}
        {"rat"                              "ate"}
        {"cat"                              "killed"}
        {"dog"                              "worried"}
        {"cow with the crumpled horn"       "tossed"}
        {"maiden all forlorn"               "milked"}
        {"man all tattered and torn"        "kissed"}
        {"priest all shaven and shorn"      "married"}
        {"rooster that crowed in the morn"  "woke"}
        {"farmer sowing his corn"           "kept"}
        {"horse and the hound and the horn" "belonged to"}
    }

    proc recite {from to} {
        for {set i [expr {$from - 1}]} {$i < $to} {incr i} {
            lappend verses [verse $i]
        }
        return [join $verses \n]
    }

    proc verse {n} {
        variable items
        set item [lindex $items $n 0]
        set verse "This is the $item"
        while {$n > 0} {
            set action [lindex $items $n   1]
            set thing  [lindex $items $n-1 0]
            append verse " that $action the $thing"
            incr n -1
        }
        return "$verse."
    }
}

namespace import JacksHouse::recite
