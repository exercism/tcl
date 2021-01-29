proc evalForth {input} {
    return [[Forth new] evaluate $input]
}


###########################################################
oo::class create Forth {
    constructor {} {
        variable stack [Stack new]
        variable macros [dict create]
    }

    method evaluate {input} {
        my variable stack
        foreach line [split $input \n] {
            my _evalLine $line
        }
        return [$stack toList]
    }

    method _evalLine {line} {
        my variable stack
        my variable macros

        set words [regexp -all -inline {\S+} [string tolower $line]]

        while {[llength $words] > 0} {
            set words [lassign $words word]

            if {[string is integer -strict $word]} {
                $stack push $word

            } elseif {[dict exists $macros $word]} {
                set words [concat [dict get $macros $word] $words]

            } else {
                switch -glob -- $word {
                    : {
                        my _setMacro $words
                        set words {}
                    }
                    [-+*/] {
                        my _binaryOp $word
                    }
                    dup - drop - swap - over {
                        my _unaryOp $word
                    }
                    default {
                        error "undefined operation"
                    }
                }
            }
        }
        return
    }

    method _setMacro {words} {
        my variable macros

        set macroValue [lassign $words macroName]
        if {[string is integer -strict $macroName]} {
            error "illegal operation"
        }

        # drop the semicolon
        if {[lindex $macroValue end] ne ";"} {
            error "macro not terminated with semicolon"
        }
        set macroValue [lrange $macroValue 0 end-1]

        # apply any existing macros
        set macroValue [lmap word $macroValue {
            if {[dict exists $macros $word]} {
                dict get $macros $word
            } else {
                set word
            }
        }]

        dict set macros $macroName $macroValue
        return
    }

    method _binaryOp {op} {
        my variable stack
        my _need 2
        set b [$stack pop]
        set a [$stack pop]
        if {$op eq "/" && $b == 0} {
            error "divide by zero"
        }
        $stack push [expr "$a $op $b"]
        return
    }

    method _unaryOp {op} {
        my variable stack
        switch $op {
            dup {
                my _need 1
                $stack push [$stack peek]
            }
            drop {
                my _need 1
                $stack pop
            }
            swap {
                my _need 2
                set first [$stack pop]
                set second [$stack pop]
                $stack push $first
                $stack push $second
            }
            over {
                my _need 2
                set first [$stack pop]
                set second [$stack peek]
                $stack push $first
                $stack push $second
            }
        }
        return
    }

    # ensure we have the wanted number of elements on the stack
    method _need {n} {
        my variable stack
        set len [$stack length]
        if {$n > 0 && $len == 0} {
            error "empty stack"
        } elseif {$n > 1 && $len == 1} {
            error "only one value on the stack"
        } elseif {$n > $len} {
            error "not enough values on the stack"
        }
        return
    }
}


###########################################################
oo::class create Stack {
    constructor {} {
        variable data {}
    }

    method length {} {
        my variable data
        return [llength $data]
    }

    method toList {} {
        my variable data
        return $data
    }

    method peek {} {
        my variable data
        return [lindex $data end]
    }

    method push {value} {
        my variable data
        lappend data $value
        return
    }

    method pop {} {
        my variable data
        set value [my peek]
        set data [lrange $data 0 end-1]
        return $value
    }
}
