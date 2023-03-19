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

    proc label {first second third args} {
        foreach var {v1 v2 v3} color [list $first $second $third] {
            set $var [colorCode $color]
        }
        set value [expr {(10 * $v1 + $v2) * 10**$v3}]

        set magnitude 0
        while {$value > 1000 && $value % 1000 == 0} {
            incr magnitude
            set value [expr {$value / 1000}]
        }

        set prefixes {"" kilo mega giga}
        return "$value [lindex $prefixes $magnitude]ohms"
    }
}
