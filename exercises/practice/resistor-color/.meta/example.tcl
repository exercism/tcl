namespace eval ::resistorColor {
    variable colors [dict create {*}{
        black   0
        brown   1
        red     2
        orange  3
        yellow  4
        green   5
        blue    6
        violet  7
        grey    8
        white   9
    }]

    proc colorCode {color} {
        variable colors
        try {
            return [dict get $colors $color]
        } on error {} {
            error "Invalid color: $color"
        }
    }

    proc colors {} {
        variable colors
        # dictionaries maintain insertion order
        return [dict keys $colors]
    }
}
