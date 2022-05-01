# translation of this lovely recursive solution
# https://exercism.org/tracks/javascript/exercises/say/solutions/515ab00bc90f46b0bde3732d9317a46b

namespace eval englishNumbers {
    # pull in some mathy things to reduce "expr" verbosity
    namespace import ::tcl::mathfunc::int
    namespace import ::tcl::mathop::\[/%*]

    namespace export say

    variable small {
        zero one two three four five six seven eight nine
        ten eleven twelve thirteen fourteen fifteen 
        sixteen seventeen eighteen nineteen
    }

    variable tens {
        20 twenty 30 thirty  40 forty  50 fifty
        60 sixty  70 seventy 80 eighty 90 ninety
    }

    proc say {n} {
        set errmsg "input out of range"
        if {$n < 0} {
            error $errmsg
        } elseif {$n < 100} {
            tailcall say_small $n
        } elseif {$n < 1e3} {
            tailcall say_compound $n 100 hundred
        } elseif {$n < 1e6} {
            tailcall say_compound $n 1e3 thousand
        } elseif {$n < 1e9} {
            tailcall say_compound $n 1e6 million
        } elseif {$n < 1e12} {
            tailcall say_compound $n 1e9 billion
        } else {
            error $errmsg
        }
    }

    proc say_small {n} {
        variable small
        variable tens
        if {$n < [llength $small]} {
            return [lindex $small $n]
        } elseif {[dict exists $tens $n]} {
            return [dict get $tens $n]
        } else {
            lassign [divmod $n 10] q rem
            return [format {%s-%s} [say [* $q 10]] [say $rem]]
        }
    }

    proc say_compound {n base word} {
        lassign [divmod $n $base] q rem
        set saying [list [say $q] $word]
        if {$rem > 0} {
            lappend saying [say $rem]
        }
        return [join $saying]
    }

    proc divmod {n div} {
        return [list [/ $n [int $div]] [% $n [int $div]]]
    }
}

namespace import englishNumbers::say
