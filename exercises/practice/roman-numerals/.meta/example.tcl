proc toroman {n} {
    set map [dict create {*}{
        1000 M  900 CM  500 D  400 CD
         100 C   90 XC   50 L   40 XL
          10 X    9 IX    5 V    4 IV
           1 I
    }]

    set r ""

    # dictionaries remember insertion order
    dict for {dec rom} $map {
        while {$n >= $dec} {
            incr n -$dec
            append r $rom
        }
    }

    return $r
}
