namespace eval dnd {
    namespace export character ability modifier
    namespace ensemble create

    namespace import ::tcl::mathop::+

    proc modifier {score} {
        return [expr {int(floor((double($score) - 10) / 2))}]
    }

    proc ability {} {
        set d6 {{} {expr {1 + int(rand() * 6)}}}
        while {[incr i] <= 4} {
            lappend dice [apply $d6]
        }
        return [+ {*}[lrange [lsort -integer $dice] 1 end]]
    }

    proc character {} {
        set c [dict create]
        foreach characteristic {
            charisma constitution dexterity
            intelligence strength wisdom
        } {
            dict set c $characteristic [ability]
        }

        set m [modifier [dict get $c constitution]]
        dict set c hitpoints [expr {10 + $m}]

        return $c
    }
}
