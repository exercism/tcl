proc eggCount {number} {
    # as a one-liner: num -> string -> list -> num
    # tcl::mathop::+ {*}[split [format %b $number] ""]

    # arithmetically
    set count 0
    while {$number > 0} {
        incr count [expr {$number & 1}]
        set number [expr {$number >> 1}]
    }
    return $count
}
