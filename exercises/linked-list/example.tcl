oo::class create LinkedList {
    variable head tail

    constructor {} {
        set head ""
        set tail ""
    }

    method push {data} {
        set node [Node new $data]
        if {$tail ne ""} {
            $tail succ -set $node
            $node prev -set $tail
        } else {
            set head $node
        }
        set tail $node
        return
    }

    method unshift {data} {
        set node [Node new $data]
        if {$head ne ""} {
            $head prev -set $node
            $node succ -set $head
        } else {
            set tail $node
        }
        set head $node
        return
    }

    method pop {} {
        if {$tail eq ""} {
            error "list is empty"
        }
        set node $tail
        if {[$node prev] ne ""} {
            [$node prev] succ -unset true
            set tail [$node prev]
        } else {
            set tail ""
            set head ""
        }
        return [$node value]
    }

    method shift {} {
        if {$head eq ""} {
            error "list is empty"
        }
        set node $head
        if {[$node succ] ne ""} {
            [$node succ] prev -unset true
            set head [$node succ]
        } else {
            set tail ""
            set head ""
        }
        return [$node value]
    }

    method for {varname script} {
        upvar 1 $varname var
        set node $head
        while {$node ne ""} {
            set var [$node value]
            uplevel 1 $script
            set node [$node succ]
        }
        return
    }

    method length {} {
        set len 0
        my for x {incr len}
        return $len
    }
}

############################################################
oo::class create Node {
    variable value
    variable succ
    variable prev

    constructor {data {succeeding ""} {previous ""}} {
        set value $data
        set succ $succeeding
        set prev $previous
    }

    method value {} {
        return $value
    }

    method succ {args} {
        if {[dict exists $args "-set"]} {
            set succ [dict get $args -set]
            return
        } elseif {[dict exists $args "-unset"]} {
            set succ ""
            return
        } else {
            return $succ
        }
    }

    method prev {args} {
        if {[dict exists $args "-set"]} {
            set prev [dict get $args -set]
            return
        } elseif {[dict exists $args "-unset"]} {
            set prev ""
            return
        } else {
            return $prev
        }
    }
}
