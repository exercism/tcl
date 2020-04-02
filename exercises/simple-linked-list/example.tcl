oo::class create Node {
    variable datum
    variable next

    constructor {value} {
        set datum $value
        set next ""
    }

    method datum {} {
        return $datum
    }

    method next {{other ""}} {
        if {$other eq ""} {
            return $next
        } else {
            set next $other
            return
        }
    }

    method clearNext {} {
        set next ""
    }
}


oo::class create SimpleLinkedList {
    variable head

    constructor {{values {}}} {
        set head ""
        foreach value $values {
            my push [Node new $value]
        }
    }

    method head {} {
        return $head
    }

    method push {node} {
        $node next $head
        set head $node
        return [self]
    }

    method pop {} {
        set node $head
        if {$node ne ""} {
            set head [$node next]
            $node clearNext
        }
        return $node
    }

    method foreach {nodeVar body} {
        upvar 1 $nodeVar node
        set node $head
        while {$node ne ""} {
            uplevel 1 $body
            set node [$node next]
        }
        return
    }

    method toList {} {
        set values {}
        my foreach node {
            lappend values [$node datum]
        }
        return $values
    }

    method reverse {} {
        if {$head ne ""} {
            set newList [[self class] new]
            while {$head ne ""} {
                $newList push [my pop]
            }
            set head [$newList head]
        }
        return [self]
    }
}
