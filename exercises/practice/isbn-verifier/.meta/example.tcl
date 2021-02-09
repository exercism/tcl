proc isValid {isbn} {
    set result false
    set isbn [string map {"-" ""} $isbn]

    if {[regexp {^\d{9}[\dX]$} $isbn]} {
        set digits [split $isbn ""]
        if {[lindex $digits end] eq "X"} {
            lset digits end 10
        }

        # using 2 accumulators precludes the need to multiply
        # https://en.wikipedia.org/wiki/International_Standard_Book_Number#ISBN-10_check_digit_calculation
        set s [set t 0]
        foreach n $digits {
            incr t $n
            incr s $t
        }
        set result [expr {$s % 11 == 0}]
    }
    return $result
}
