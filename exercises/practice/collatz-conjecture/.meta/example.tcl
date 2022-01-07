proc steps {n {step 0}} {
    if {$n <= 0} {
        error "Only positive integers are allowed"
    }
    if {$n == 1} {
        return $step
    }
    tailcall steps [nextValue $n] [expr {$step + 1}]
}

proc nextValue {n} {
    expr {even($n) ? ($n / 2) : (3 * $n + 1)}
}

proc ::tcl::mathfunc::even {n} {
    expr {$n % 2 == 0} 
}
