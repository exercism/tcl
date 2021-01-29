namespace import {::tcl::mathop::[-+*/]}

proc answer {question} {
    set question [regsub {^What is} [string trim $question] ""]
    set question [regsub {\?$} $question ""]

    if {$question eq ""} {
        error "syntax error"
    }

    # the expression
    set exp [string map {
        "multiplied by"  * 
        "divided by"     /
        plus             + 
        minus            - 
    } [string trim $question]]

    # now, all the letters _should_ be gone
    if {[regexp {[^\d\s*/+-]} $exp]} {
        error "unknown operation"
    }

    # Instead of assuming the operands and operators are space-separated,
    # let's extract them: "1+2*-3" --> "1 + 2 * -3"
    set exp [join [regexp -all -inline -expanded -- {-?\d+ | [-+*/]} $exp]]

    foreach regex {
        { [-+*/] \s ( [+*/] | -(\D|$) )  # 2 consecutive operators }
        { \d \s -?\d                     # 2 consecutive operands  }
    } {
        if {[regexp -expanded $regex $exp]} {
            error "syntax error"
        }
    }

    #########################################################
    # It would be nice at this point to just do
    #     try {
    #         return [expr $exp]
    #     } trap {TCL PARSE EXPR} {} {
    #         error "syntax error"
    #     }
    # but `expr` will do the proper order of arithmetic operations,
    # instead of executing the operations from left to right,
    # as the tests want
    #        tcl:  1 + 2 * -3 returns -5
    #        test: 1 + 2 * -3 expects -9
    #########################################################


    # A regular expression to match and capture:
    #     an operand and an operator and an operand.
    set subexpr {(-?\d+) \s ([-+*/]) \s (-?\d+)}

    while {[llength $exp] > 1} {
        # replace "a + b * c" with "[+ a b] * c" ...
        if {![regsub -expanded $subexpr $exp {[\2 \1 \3]} cmd]} {
            error "syntax error"
        }
        # ... and then perform the command substitution
        set exp [subst $cmd]
    }
    return $exp
}
