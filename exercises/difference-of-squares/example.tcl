proc squareOfSum {n} {
    set sum 0
    for {set i 1} {$i <= $n} {incr i} {
        incr sum $i
    }
    return [expr {$sum ** 2}]
}

proc sumOfSquares {n} {
    set sum 0
    for {set i 1} {$i <= $n} {incr i} {
        incr sum [expr {$i ** 2}]
    }
    return $sum
}

proc  differenceOfSquares {n} {
    return [expr {[squareOfSum $n] - [sumOfSquares $n]}]
}
