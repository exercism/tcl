proc rectangles {input} {
    return [[Rectangles new $input] count]
}

############################################################
oo::class create Rectangles {
    variable grid
    variable vertices

    constructor {input} {
        set grid [lmap row $input {split $row ""}]
        set vertices [list]
    }

    method count {} {
        set count 0
        my findVertices

        foreach topLeft $vertices {
            foreach topRight [my verticesRightOf $topLeft] {
                foreach bottomLeft [my verticesBelow $topLeft] {
                    set bottomRight [Vertex new [$bottomLeft row] [$topRight column]]

                    # is there such a vertex?
                    set vs [lselect v $vertices {$v equals $bottomRight}]
                    if {[llength $vs] != 1} {
                        continue
                    }

                    if {[my isRectangle $topLeft $topRight $bottomLeft $bottomRight]} {
                        incr count
                    }
                }
            }
        }
        return $count
    }

    method findVertices {} {
        for {set row 0} {$row < [llength $grid]} {incr row} {
            for {set col 0} {$col < [llength [lindex $grid 0]]} {incr col} {
                if {[lindex $grid $row $col] eq "+"} {
                    lappend vertices [Vertex new $row $col]
                }
            }
        }
    }

    method verticesRightOf {vertex} {
        lselect v $vertices {
            expr {[$v row] == [$vertex row] && [$v column] > [$vertex column]}
        }
    }

    method verticesBelow {vertex} {
        lselect v $vertices {
            expr {[$v column] == [$vertex column] && [$v row] > [$vertex row]}
        }
    }

    method isRectangle {topLeft topRight bottomLeft bottomRight} {
        expr {
            [my isVerticalEdge $topLeft $bottomLeft] &&
            [my isVerticalEdge $topRight $bottomRight] &&
            [my isHorizontalEdge $topLeft $bottomLeft] &&
            [my isHorizontalEdge $topRight $bottomRight]
        }
    }

    method isVerticalEdge {top bottom} {
        for {set row [$top row]} {$row <= [$bottom row]} {incr row} {
            if {[lindex $grid $row [$top column]] ni {"+" "|"}} {
                return false
            }
        }
        return true
    }

    method isHorizontalEdge {left right} {
        for {set col [$left column]} {$col <= [$right column]} {incr col} {
            if {[lindex $grid [$left row] $col] ni {"+" "-"}} {
                return false
            }
        }
        return true
    }
}

############################################################
oo::class create Vertex {
    variable r c

    constructor {row column} {
        set r $row
        set c $column
    }

    method row    {} {return $r}
    method column {} {return $c}

    method equals {other} {
        expr {[my row] == [$other row] && [my column] == [$other column]}
    }
}

############################################################
proc lselect {varName list body} {
    upvar 1 $varName element
    lmap element $list {
        if {[uplevel 1 $body]} then {set element} else continue
    }
}
