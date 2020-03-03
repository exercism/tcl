oo::class create Robot {
    variable x y dir
    variable turn step 

    constructor {{position {}}} {
        set defaultPos {x 0 y 0 direction north}
        set initialPosition [dict merge $defaultPos $position]

        set x   [dict get $initialPosition x]
        set y   [dict get $initialPosition y]
        set dir [dict get $initialPosition direction]

        set turn [dict create {*}{
            north {R east  L west}
            east  {R south L north}
            south {R west  L east}
            west  {R north L south}
        }]

        set step [dict create {*}{
            north {x  0  y  1}
            east  {x  1  y  0}
            south {x  0  y -1}
            west  {x -1  y  0}
        }]

        if {![dict exists $turn $dir]} {
            error "invalid direction"
        }
        foreach coord {x y} {
            if {![string is integer -strict [set $coord]]} {
                error "invalid $coord coordinate"
            }
        }
    }

    method position {} {
        return [dict create x $x y $y direction $dir]
    }

    method move {instructions} {
        foreach instruction [split $instructions ""] {
            switch -- $instruction {
                A       {my advance}
                R - L   {my turn $instruction}
                default {error "invalid instruction: $instruction"}
            }
        }
    }

    method turn {way} {
        set dir [dict get $turn $dir $way]
    }

    method advance {} {
        incr x [dict get $step $dir x]
        incr y [dict get $step $dir y]
    }

    # private methods
    unexport turn advance
}
