oo::class create Rational {
    constructor {numerator denominator} {
        set gcd [expr {gcd(abs($numerator), abs($denominator))}]
        set m [expr {$denominator < 0 ? -1 : 1}]
        variable num [expr {$m * $numerator / $gcd}]
        variable den [expr {$m * $denominator / $gcd}]
    }

    method numerator {} {
        my variable num
        return $num
    }

    method denominator {} {
        my variable den
        return $den
    }

    method toString {} {
        my variable num den
        return "$num/$den"
    }

    method recip {} {
        my variable num den
        return [Rational new $den $num]
    }

    method add {other} {
        my variable num den
        set n [expr {
            $num * [$other denominator] + $den * [$other numerator]
        }]
        set d [expr {$den * [$other denominator]}]
        return [Rational new $n $d]
    }

    method sub {other} {
        set neg [Rational new [expr {-1 * [$other numerator]}] [$other denominator]]
        return [my add $neg]
    }

    method mul {other} {
        my variable num den
        set n [expr {$num * [$other numerator]}]
        set d [expr {$den * [$other denominator]}]
        return [Rational new $n $d]
    }

    method div {other} {
        return [my mul [$other recip]]
    }

    method abs {} {
        my variable num den
        return [Rational new [expr {abs($num)}] $den]
    }

    method pow {power} {
        my variable num den
        if {$power >= 0} {
            set n [expr {$num ** $power}] 
            set d [expr {$den ** $power}]
        } else {
            set n [expr {$den ** (-1 * $power)}]
            set d [expr {$num ** (-1 * $power)}] 
        }
        return [Rational new $n $d]
    }

    method exprational {base} {
        my variable num den
        return [expr {nthroot(double($base) ** $num, $den)}]
    }
}


###########################################################
proc ::tcl::mathfunc::gcd {a b} {
    if {$b == 0} {
        return $a
    }
    set procname [lindex [info level 0] 0]
    tailcall $procname $b [expr {$a % $b}]
}

proc ::tcl::mathfunc::nthroot {num root} {
    return [expr { exp(1) ** (log($num) / $root) }]
}
