# The simple nested loops solution is very slow.
# This algorithm lifted from
# https://exercism.io/tracks/python/exercises/palindrome-products/solutions/d68cab86cad94d4d821f26da44bb0722

namespace eval palindromeProducts {
    namespace export smallest largest
    namespace ensemble create

    proc smallest {min max} {
        main $min $max 1
    }

    proc largest {min max} {
        main $min $max -1
    }

    proc main {min max step} {
        if {$min > $max} {
            error "min must be <= max"
        }

        if {$step == 1} {
            # smallest: start looping from the least product
            set start [expr {$min ** 2}]
            set end   [expr {$max ** 2}]
            set loopCond {{i end} {expr {$i <= $end}}}
        } else {
            # largest: start looping from the greatest product
            set start [expr {$max ** 2}]
            set end   [expr {$min ** 2}]
            set loopCond {{i end} {expr {$i >= $end}}}
        }

        set prod -1
        set factors {}

        set i $start
        while {[apply $loopCond $i $end]} {
            if {[isPalindrome $i]} {
                set factors [factors $i $min $max $step]
                if {[llength $factors] > 0} {
                    set prod $i
                    # OK, we've found the smallest/largest: We're done
                    break
                }
            }
            incr i $step
        }

        return [list $prod $factors]
    }

    proc factors {n min max step} {
        if {$step == 1} {
            set i $min
            set cond {{i n} {expr {$i**2 <= $n}}}
        } else {
            set i $max
            set cond {{i n} {expr {$i**2 >= $n}}}
        }
        set factors {}

        while {[apply $cond $i $n]} {
            set j [expr {$n / $i}]
            if {$i * $j == $n && $min <= $j && $j <= $max} {
                lappend factors [lsort -integer [list $i $j]]
            }
            incr i $step
        }
        return $factors
    }

    proc isPalindrome {n} {
        expr {$n eq [string reverse $n]}
    }
}
