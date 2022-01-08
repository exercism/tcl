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
        return [string trimleft [join $codes ""] 0]
    }
}
