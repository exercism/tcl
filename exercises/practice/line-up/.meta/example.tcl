namespace eval TakeANumber {
    namespace export formatTicket

    variable template {%s, you are the %s customer we serve today. Thank you!}

    proc ordinal {number} {
        set suffix "th"
        if {($number % 100) ni {11 12 13}} {
            switch [expr {$number % 10}] {
                1 {set suffix "st"}
                2 {set suffix "nd"}
                3 {set suffix "rd"}
            }
        }
        return "${number}${suffix}"
    }

    proc formatTicket {name number} {
        variable template
        format $template $name [ordinal $number]
    }
}

namespace import TakeANumber::formatTicket
