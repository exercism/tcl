oo::class create Matrix {
    constructor {inputString} {
        variable rows    [lmap line [split $inputString \n] {split $line}]
        variable columns [my Transpose $rows]
    }

    method Transpose {rows} {
        set columns [lrepeat [llength [lindex $rows 0]] {}]
        for {set r 0} {$r < [llength $rows]} {incr r} {
            for {set c 0} {$c < [llength $columns]} {incr c} {
                lset columns $c $r [lindex $rows $r $c]
            }
        }
        return $columns
    }

    method row {n} {
        my variable rows
        return [lindex $rows $n-1]
    }

    method column {n} {
        my variable columns
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
