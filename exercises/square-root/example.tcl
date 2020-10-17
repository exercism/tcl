# Using the Binary numeral system implementation from
# https://en.wikipedia.org/wiki/Methods_of_computing_square_roots#Binary_numeral_system_(base_2)

proc squareRoot {n} {
    set x 0
    # find b, the largest power of 4 <= n
    set i [expr {int(floor(log($n) / log(2)))}]
    set b [expr {2 ** ($i % 2 == 1 ? $i-1 : $i)}]

    while {$b != 0} {
        if {$n >= $x + $b} {
            set n [expr {$n - $x - $b}]
            set x [expr {$x / 2 + $b}]
        } else {
            set x [expr {$x / 2}]
        }
        set b [expr {$b / 4}]
    }
    return $x
}
