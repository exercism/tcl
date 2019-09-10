oo::class create Matrix {
    constructor {inputString} {
        variable rows
        set rows [lmap line [split $inputString \n] {split $line}]
    }

    method row {n} {
        my variable rows
        return [lindex $rows $n-1]
    }

    method column {n} {
        my variable rows
        return [lmap row $rows {lindex $row $n-1}]
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
