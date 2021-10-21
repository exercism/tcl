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

# `expr` functions that take a real and a complex, in some order
namespace eval ::tcl::mathfunc {
    proc cr_add {a b} {_complex_operation add $a $b}
    proc cr_sub {a b} {_complex_operation sub $a $b}
    proc cr_mul {a b} {_complex_operation mul $a $b}
    proc cr_div {a b} {_complex_operation div $a $b}

    proc _complex_operation {op a b} {
        _coerce_to_complex a
        _coerce_to_complex b
        return [$a $op $b]
    }

    proc _coerce_to_complex {varName} {
        upvar 1 $varName var
        if {[string is double -strict $var]} {
            set var [ComplexNumber new $var 0]
        }
        if {![info object isa typeof $var ComplexNumber]} {
            error "expected floating-point number or ComplexNumber but got \"$var\""
        }
    }
}
