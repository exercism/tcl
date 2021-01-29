proc keep {varname list condition {keep true}} {
    upvar 1 $varname element
    set kept {}
    foreach element $list {
        if {!![uplevel 1 $condition] == !!$keep} {
            lappend kept $element
        }
    }
    return $kept
}

proc discard {varname list condition} {
    # Use `tailcall` so that we're still 1 level below the caller:
    # without it, this invocation of keep would put us 2 levels below.
    tailcall keep $varname $list $condition false
}
