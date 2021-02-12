namespace eval twelveDays {

    namespace export verse sing

    variable days {
        "" first second third fourth fifth sixth
        seventh eighth ninth tenth eleventh twelfth
    }

    variable gifts {
        ""
        "a Partridge in a Pear Tree"
        "two Turtle Doves"
        "three French Hens"
        "four Calling Birds"
        "five Gold Rings"
        "six Geese-a-Laying"
        "seven Swans-a-Swimming"
        "eight Maids-a-Milking"
        "nine Ladies Dancing"
        "ten Lords-a-Leaping"
        "eleven Pipers Piping"
        "twelve Drummers Drumming"
    }

    proc verse {n} {
        variable days
        variable gifts

        set presents [lreverse [lrange $gifts 1 $n]]
        if {$n > 1} {
            lset presents end "and [lindex $presents end]"
        }

        return [format "On the %s day of Christmas my true love gave to me: %s." \
            [lindex $days $n] \
            [join $presents ", "] ]
    }

    proc sing {from to} {
        for {set i $from} {$i <= $to} {incr i} {
            lappend verses [verse $i]
        }
        return [join $verses "\n"]
    }
}

namespace import twelveDays::*
