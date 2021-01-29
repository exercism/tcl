oo::class create Queen {
    variable row col

    constructor {x y} {
        set row $x
        set col $y
        if {$x < 0} { error "row not positive" }
        if {$x > 7} { error "row not on board" }
        if {$y < 0} { error "column not positive" }
        if {$y > 7} { error "column not on board" }
    }

    method row {} { return $row }
    method col {} { return $col }

    method canAttack {other} {
        if {![info object isa object $other]} {
            error "not a Queen"
        }

        # does $other quack like a Queen?
        set otherMethods [info object methods $other -all]
        if {"row" ni $otherMethods || "col" ni $otherMethods} {
            error "not a Queen"
        }

        set dx [expr {abs([my row] - [$other row])}]
        set dy [expr {abs([my col] - [$other col])}]
        if {$dx == 0 && $dy == 0} {
            error "same position"
        }
        return [expr {$dx == 0 || $dy == 0 || $dx == $dy}]
    }
}
