# The simple nested loops solution is very slow. The algorithm is
# lifted from @ILoveMuffins's Python solution to the same problem:
# https://exercism.org/tracks/python/exercises/palindrome-products/solutions/d68cab86cad94d4d821f26da44bb0722

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

        set prod -1
        set factors {}

        set minProduct [expr {$min ** 2}]
        set maxProduct [expr {$max ** 2}]
        if {$step > 0} {
            # smallest: start looping from the least product
            set range [list $minProduct $maxProduct $step]
        } else {
            # largest: start looping from the greatest product
            set range [list $maxProduct $minProduct $step]
        }

        foreachInRange i $range {
            if {[isPalindrome $i]} {
                set factors [factors $i $min $max $step]
                if {[llength $factors] > 0} {
                    set prod $i
                    # OK, we've found the smallest/largest: We're done
                    break
                }
            }
        }

        return [list $prod $factors]
    }

    proc factors {n min max step} {
        set factors {}
        set start [expr {$step > 0 ? $min : $max}]
        set end   [expr {sqrt($n)}]

        foreachInRange i [list $start $end $step] {
            set j [expr {$n / $i}]
            if {$i * $j == $n && $min <= $j && $j <= $max} {
                lappend factors [lsort -integer [list $i $j]]
            }
        }
        return $factors
    }

    proc isPalindrome {n} {
        expr {$n eq [string reverse $n]}
    }
}


# iterate over a closed range
#
# The `range` argument is a 3-element list:
#     { startValue endValue step }
#
# example:
#     foreachInRange i {1 10 2} {puts $i}
#
proc foreachInRange {loopVarname range script} {
    lassign $range fromVal toVal step
    if {
            $step == 0
         || ($step > 0 && $fromVal > $toVal)
         || ($step < 0 && $fromVal < $toVal)
    } {
        error "infinite loop: start=$fromVal, end=$toVal, step=$step"
    }

    upvar 1 $loopVarname loopVar
    set loopVar $fromVal
    while {
            ($step > 0 && $loopVar <= $toVal)
         || ($step < 0 && $loopVar >= $toVal)
    } {
        uplevel 1 $script
        incr loopVar $step
    }
}
