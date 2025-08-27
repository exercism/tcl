proc parse {input} {
    if {![regexp -- {^\(.*\)$} $input]} {
        error "tree missing"
    }

    set result [parse_node $input 1]
    return [lindex $result 0]
}

# glennj: Not my best work here, but it's working.
# Inspired by the python example.

proc parse_node {content idx} {
    if {[string index $content $idx] ne ";"} {
        error "tree with no nodes"
    }

    set tree {properties {} children {}}
    incr idx

    set state CollectName
    set name ""
    set value ""
    set escaped false
    set escapedBracket false

    while {$idx < [string length $content]} {
        set char [string index $content $idx]

        switch -exact $state {
            CollectName {
                switch -exact -- $char {
                    "\[" {
                        if {[regexp {[^[:upper:]]} $name]} {
                            error "property must be in uppercase"
                        }
                        if {$name ne ""} {
                            set propertyName $name
                        }
                        set state CollectValue
                        set name ""
                    } 
                    ")" {
                        # end of node, return
                        incr idx
                        break
                    } 
                    ";" {
                        # add one child node
                        lassign [parse_node $content $idx] child idx
                        dict lappend tree children $child
                    } 
                    "(" {
                        # expect a child node next
                    }
                    default {
                        append name $char
                    }
                }
            # end CollectName
            }

            CollectValue {
                if {$escaped} {
                    switch -exact -- $char {
                        n {
                            # newline
                            set char "\n"
                        }
                        t - v - f - r - b {
                            # other whitespace
                            set char " "
                        }
                        "]" {
                            set escapedBracket true
                        }
                    }
                }

                # trickiness to handle an escaped escape-char
                set escaped [expr {$char eq "\\" ? !$escaped : "false"}]

                if {$char eq "]" && !$escapedBracket} {
                    set props [dict get $tree properties]
                    dict lappend props $propertyName $value
                    dict set tree properties $props
                    set state CollectName
                    set value ""
                } elseif {!$escaped} {
                    if {$escapedBracket} {
                        set escapedBracket false
                    }
                    if {[string match {*\\} $value]} {
                        if {$char in {t n " " "\n"}} {
                            set value [string range $value 0 end-1]
                        }
                        if {$char eq "\n"} {
                            set char ""
                        }
                    }
                    append value $char
                }
            # end CollectValue
            } 
        }

        incr idx
    }

    if {$state eq "CollectName" && $name ne ""} {
        error "properties without delimiter"
    }

    return [list $tree $idx]
}
