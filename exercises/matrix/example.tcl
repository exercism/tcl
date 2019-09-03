oo::class create Matrix {
    constructor {inputString} {
        variable input  $inputString
        variable parsed false
        variable rows
        variable columns
    }

    method ParseInput {} {
        my variable rows columns input parsed

        set rows [lmap line [split $input \n] {split $line}]

        set columns [lrepeat [llength [lindex $rows 0]] {}]
        for {set r 0} {$r < [llength $rows]} {incr r} {
            for {set c 0} {$c < [llength $columns]} {incr c} {
                lset columns $c $r [lindex $rows $r $c]
            }
        }

        set parsed true
    }

    method row {n} {
        my variable parsed rows
        if {!$parsed} {
            my ParseInput
        }
        return [lindex $rows $n-1]
    }

    method column {n} {
        my variable parsed columns
        if {!$parsed} {
            my ParseInput
        }
        return [lindex $columns $n-1]
    }
}

proc matrixFrom {inputString} {
    Matrix new $inputString
}

proc row {matrix n} {
    $matrix row $n
}

proc column {matrix n} {
    $matrix column $n
}
