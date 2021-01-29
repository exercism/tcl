proc accumulate {varname list body} {
    upvar 1 $varname element
    set result [list]
    foreach element $list {
        lappend result [uplevel 1 $body]
    }
    return $result
}
