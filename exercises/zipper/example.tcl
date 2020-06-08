source ./tree.tcl

oo::class create Zipper {
    variable tree
    variable focus
    variable parent

    constructor {aTree {aFocus ""} {aParent ""}} {
        set tree $aTree
        set focus [expr {$aFocus eq "" ? $aTree : $aFocus}]
        set parent $aParent
    }

    method tree {} {return $tree}
    method focus {} {return $focus}
    method parent {} {return $parent}
    method value {} {return [$focus value]}

    method left {} {
        if {[$focus left] ne ""} {
            return [Zipper new $tree [$focus left] [self]]
        }
        return ""
    }

    method right {} {
        if {[$focus right] ne ""} {
            return [Zipper new $tree [$focus right] [self]]
        }
        return ""
    }

    method up {} {
        if {$parent ne ""} {
            return [Zipper new $tree [$parent focus] [$parent parent]]
        }
        return ""
    }

    method setValue {value} {
        $focus setValue $value
    }

    method setLeft {aTree} {
        $focus setLeft $aTree
    }

    method setRight {aTree} {
        $focus setRight $aTree
    }

    method equals {other} {
        expr {
            [[my tree] equals [$other tree]] &&
            [[my focus] equals [$other focus]]
        }
    }
}
