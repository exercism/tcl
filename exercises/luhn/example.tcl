proc luhn {digits} {
    regsub -all {\s} $digits {} digits
    if {[regexp {\D} $digits] || [string length $digits] == 1} {
        return false
    }

    set sum 0
    set idx -1
    foreach d [lreverse [split $digits {}]] {
        incr sum [lindex {
            {0 1 2 3 4 5 6 7 8 9}
            {0 2 4 6 8 1 3 5 7 9}
        } [expr {[incr idx] % 2}] $d]
    }
    return [expr {($sum % 10) == 0}]
}
