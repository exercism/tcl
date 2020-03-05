namespace eval listOps {}

# core list commands used here: foreach, list

proc ::listOps::append {listname values} {
    upvar 1 $listname L
    set L [list {*}$L {*}$values]
}

proc ::listOps::prepend {listname values} {
    upvar 1 $listname L
    set L [list {*}$values {*}$L]
}

proc ::listOps::concat {listOfLists} {
    set result {}
    foreach list $listOfLists {
        ::listOps::append result $list
    }
    return $result
}

proc ::listOps::filter {list func} {
    set result [list]
    foreach element $list {
        if {[uplevel 1 [list apply $func $element]]} {
            ::listOps::append result $element
        }
    }
    return $result
}

proc ::listOps::length {list} {
    set length 0
    foreach element $list {
        incr length
    }
    return $length
}

proc ::listOps::map {list func} {
    set result [list]
    foreach element $list {
        ::listOps::append result [uplevel 1 [list apply $func $element]]
    }
    return $result
}

proc ::listOps::foldl {list accumulator func} {
    foreach element $list {
        set accumulator [uplevel 1 [list apply $func $accumulator $element]]
    }
    return $accumulator
}

proc ::listOps::reverse {list} {
    return [::listOps::foldl $list {} {{acc elem} {
        ::listOps::prepend acc [list $elem]
    }}]
}

proc ::listOps::foldr {list accumulator func} {
    foreach element [::listOps::reverse $list] {
        set accumulator [uplevel 1 [list apply $func $element $accumulator]]
    }
    return $accumulator
}
