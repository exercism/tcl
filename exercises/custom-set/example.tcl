oo::class create Set {
    variable elements

    constructor {{data {}}} {
        # use a dictionary, the keys will be unique
        set elements [dict create]
        foreach element $data {
            dict set elements $element ""
        }
    }

    method toList {} {
        return [dict keys $elements]
    }

    method size {} {
        return [dict size $elements]
    }

    method isEmpty {} {
        return [expr {[my size] == 0}]
    }

    method contains {element} {
        return [dict exists $elements $element]
    }

    # All of my elements are in the other set.
    # Assume other is a Set.
    method subsetOf {other} {
        dict for {elem _} $elements {
            if {![$other contains $elem]} {
                return false
            }
        }
        return true
    }

    # None of my elements are in the other set.
    # Assume other is a Set.
    method disjoint {other} {
        dict for {elem _} $elements {
            if {[$other contains $elem]} {
                return false
            }
        }
        return true
    }

    method equals {other} {
        return [expr {[my size] == [$other size] && [my subsetOf $other]}]
    }

    method add {element} {
        dict set elements $element ""
    }

    # Intersection returns a new Set
    method intersection {other} {
        set result [[self class] new]
        dict for {elem _} $elements {
            if {[$other contains $elem]} {
                $result add $elem
            }
        }
        return $result
    }

    # Difference returns a new Set
    method difference {other} {
        set result [[self class] new]
        dict for {elem _} $elements {
            if {![$other contains $elem]} {
                $result add $elem
            }
        }
        return $result
    }

    # Union returns a new Set
    method union {other} {
        set elems [concat [my toList] [$other toList]]
        return [[self class] new $elems]
    }
}
