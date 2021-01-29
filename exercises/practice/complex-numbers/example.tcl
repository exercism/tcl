oo::class create ComplexNumber {
    variable a b

    constructor {real imag} {
        # a + i*b
        set a $real
        set b $imag
    }

    method real {} {return $a}
    method imag {} {return $b}

    method toList {} {return [list $a $b]}

    method add {other} {
        lassign [$other toList] c d
        return [ComplexNumber new [expr {$a + $c}] [expr {$b + $d}]]
    }

    method sub {other} {
        lassign [$other toList] c d
        return [ComplexNumber new [expr {$a - $c}] [expr {$b - $d}]]
    }

    method mul {other} {
        lassign [$other toList] c d
        set r [expr {$a * $c - $b * $d}]
        set i [expr {$b * $c + $a * $d}]
        return [ComplexNumber new $r $i]
    }

    method div {other} {
        lassign [$other toList] c d
        set r [expr {double($a * $c + $b * $d) / ($c ** 2 + $d ** 2)}]
        set i [expr {double($b * $c - $a * $d) / ($c ** 2 + $d ** 2)}]
        return [ComplexNumber new $r $i]
    }

    method abs {} {
        return [expr {hypot($a, $b)}]
    }

    method conj {} {
        return [ComplexNumber new $a [expr {-$b}]]
    }

    method exp {} {
        set x [ComplexNumber new [expr {exp(1) ** $a}] 0]
        set y [ComplexNumber new [expr {cos($b)}] [expr {sin($b)}]]
        return [$x mul $y]
    }
}
