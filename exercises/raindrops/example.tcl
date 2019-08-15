proc raindrops {num} {
    foreach div {3 5 7} vowel {i a o} {
        if {$num % $div == 0} {
            append sounds "Pl${vowel}ng"
        }
    }
    # if no divisors, then the sounds variable does not yet exist
    expr {[info exists sounds] ? $sounds : $num}
}
