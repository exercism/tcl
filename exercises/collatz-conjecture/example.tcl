# next number functions
set functions {
    {n {expr {$n / 2}}}
    {n {expr {3 * $n + 1}}}
}

proc steps {n {step 0}} {
    if {$n <= 0} {
        error "Only positive numbers are allowed"
    }
    if {$n == 1} {
        return $step
    }
    set func [lindex $::functions [expr {$n % 2}]]
    tailcall steps [apply $func $n] [expr {$step + 1}]
}
