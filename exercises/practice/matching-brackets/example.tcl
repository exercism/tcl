proc bracketsMatch {input} {
    array set openBracket [list "\}" "\{" "\]" "\[" ")" "(" ]
    set stack [Stack new]

    foreach char [split $input ""] {
        switch -exact -- $char {
            "\{" - "\[" - "(" {$stack push $char}
            "\}" - "]" - ")" {
                if {[$stack isEmpty] || [$stack pop] ne $openBracket($char)} {
                    return false
                }
            }
        }
    }

    return [$stack isEmpty]
}

oo::class create Stack {
    variable data

    constructor {} {
        set data [list]
    }

    method push {element} {
        lappend data $element
        return
    }

    method pop {} {
        # opportunity for performance enhancement here, if needed
        # see https://wiki.tcl-lang.org/page/K

        set element [lindex $data end]
        set data [lreplace $data end end]
        return $element

        # in Tcl 8.7, this proc can be written as
        # lpop data end
    }

    method isEmpty {} {
        return [expr {[llength $data] == 0}]
    }
}
