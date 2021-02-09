oo::class create BinarySearchTree {
    variable data
    variable left
    variable right

    method data {} {
        return [expr {[info exists data] ? $data : ""}]
    }

    method left {} {
        return [expr {[info exists left] ? $left : ""}]
    }

    method right {} {
        return [expr {[info exists right] ? $right : ""}]
    }

    method insert {number} {
        if {![info exists data]} {
            set data $number
        } elseif {$number <= $data} {
            if {![info exists left]} {
                set left [[self class] new]
            }
            tailcall $left insert $number
        } else {
            if {![info exists right]} {
                set right [[self class] new]
            }
            tailcall $right insert $number
        }
        return
    }

    method sorted {} {
        my map node {$node data}
    }

    method map {varName body} {
        upvar 1 $varName var
        set result {}
        my foreach var {lappend result [uplevel 1 $body]}
        return $result
    }

    method foreach {varName body {level 1}} {
        if {[info exists left]} {
            $left foreach $varName $body [expr {$level + 1}]
        }

        upvar $level $varName var
        set var [self]
        uplevel $level $body

        if {[info exists right]} {
            $right foreach $varName $body [expr {$level + 1}]
        }
    }

    method toDict {} {
        set result [list data $data left {} right {}]
        if {[info exists left]} {
            dict set result left [$left toDict]
        }
        if {[info exists right]} {
            dict set result right [$right toDict]
        }
        return $result
    }
}
