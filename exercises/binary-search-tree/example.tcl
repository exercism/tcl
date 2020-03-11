oo::class create BinarySearchTree {
    variable data
    variable left
    variable right

    method data {} {
        if {[info exists data]} {
            return $data
        }
        return
    }

    method hasLeft {} {
        return [info exists left]
    }

    method hasRight {} {
        return [info exists right]
    }

    method left {} {
        if {[my hasLeft]} {
            return $left
        }
        return
    }

    method right {} {
        if {[my hasRight]} {
            return $right
        }
        return
    }

    method insert {number} {
        if {![info exists data]} {
            set data $number
        } elseif {$number <= $data} {
            if {[my hasLeft]} {
                tailcall $left insert $number
            } else {
                set left [[self class] new]
                $left insert $number
            }
        } else {
            if {[my hasRight]} {
                tailcall $right insert $number
            } else {
                set right [[self class] new]
                $right insert $number
            }
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
        if {[my hasLeft]} {
            $left foreach $varName $body [expr {$level + 1}]
        }

        upvar $level $varName var
        set var [self]
        uplevel $level $body

        if {[my hasRight]} {
            $right foreach $varName $body [expr {$level + 1}]
        }
    }
}
