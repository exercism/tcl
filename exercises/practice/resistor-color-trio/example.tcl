namespace eval ::resistorColor {
    variable colors {
        black brown red orange yellow green blue violet grey white
    }

    proc colorCode {color} {
        variable colors
        set idx [lsearch -exact $colors $color]
        if {$idx == -1} {
            error "Invalid color: $color"
        }
        return $idx
    }

    proc value {first second args} {
        set codes [lmap c [list $first $second] {colorCode $c}]
        return [join $codes ""]
    }

    proc label {first second third args} {
        set value [expr {[value $first $second] * 10**[colorCode $third]}]

        set magnitude 0
        while {$value > 1000 && $value % 1000 == 0} {
            incr magnitude
            set value [expr {$value / 1000}]
        }

        set prefixes {"" kilo mega giga}
        return "$value [lindex $prefixes $magnitude]ohms"
    }
}
