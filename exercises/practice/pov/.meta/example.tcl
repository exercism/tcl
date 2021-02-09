oo::class create Tree {
    variable label
    variable children
    variable parent

    constructor {input} {
        set label [dict get $input label]
        set parent ""
        set children [list]
        if {[dict exists $input children]} {
            foreach childInput [dict get $input children] {
                my addChild [Tree new $childInput]
            }
        }
    }

    method label  {} {return $label}
    method parent {} {return $parent}

    method setParent {node} {
        set parent $node
    }

    method addChild {child} {
        lappend children $child
        $child setParent [self]
    }

    method removeChild {child} {
        set idx [lsearch -exact $children $child]
        if {$idx != -1} {
            set children [lreplace $children $idx $idx]
            $child setParent ""
        }
    }

    method toDict {} {
        set result [dict create]
        dict set result label $label
        if {[llength $children] > 0} {
            dict set result children [lmap c $children {$c toDict}]
        }
        return $result
    }

    method find {aLabel} {
        if {$label eq $aLabel} {
            return [self]
        }
        foreach child $children {
            set node [$child find $aLabel]
            if {$node ne ""} {
                return $node
            }
        }
        return ""
    }

    method fromPov {aLabel} {
        set newRoot [my find $aLabel]
        if {$newRoot eq ""} {
            error "no such target"
        }
        if {$newRoot ne [self]} {
            # follow the path downward, removing the node from
            # its parent's children, and adding the node's parent
            # to its own children
            #
            set path [lreverse [$newRoot pathToRoot]]
            set parent [lindex $path 0]
            foreach node [lrange $path 1 end] {
                $parent removeChild $node
                $node addChild $parent
                set parent $node
            }
        }
        $newRoot setParent ""
        return $newRoot
    }

    method path {fromLabel toLabel} {
        set from [my find $fromLabel]
        if {$from eq ""} {
            error "no such label"
        }
        set to [my find $toLabel]
        if {$to eq ""} {
            error "no such label"
        }

        set fromPath [$from pathToRoot]
        set toPath [$to pathToRoot]

        lassign [my stripCommonAntecedents $fromPath $toPath] fromPath toPath

        set path [concat $fromPath [lrange [lreverse $toPath] 1 end]]
        return [lmap node $path {$node label}]
    }

    method pathToRoot {} {
        if {$parent eq ""} {
            return [self]
        } else {
            return [concat [self] [$parent pathToRoot]]
        }
    }

    method stripCommonAntecedents {path1 path2} {
        set len [expr {min([llength $path1], [llength $path2])}]
        for {set i 0} {$i < $len} {incr i} {
            if {[lindex $path1 end-$i] ne [lindex $path2 end-$i]} {
                break
            }
        }
        incr i -1 ;# we want to keep the first common ancestor
        return [list [lrange $path1 0 end-$i] [lrange $path2 0 end-$i]]
    }
}


proc fromPov {input label} {
    set tree [Tree new $input]
    set newTree [$tree fromPov $label]
    return [$newTree toDict]
}

proc path {input from to} {
    set tree [Tree new $input]
    return [$tree path $from $to]
}
