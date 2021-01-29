# Algorithm taken from Wikipedia:
# https://en.wikipedia.org/wiki/Knapsack_problem
# 
# Define m[i,w] to be the maximum value that can be attained
# with weight less than or equal to w using items up to i
# (first i items).
# 
# We can define m[i,w] recursively as follows:
# 
#     m[0,w] = 0
#     m[i,w] = m[i−1,w] if w_{i} > w (the new item is more than the current weight limit)
#     m[i,w] = max (m[i−1,w], m[i−1, w − w_{i}] + v_{i}) if w_{i} ⩽ w

proc maximumValue {maxWeight items} {
    set weights {0}
    set values {0}

    foreach item $items {
        lappend weights [dict get $item weight]
        lappend values  [dict get $item value]
    }

    set n [llength $items]
    array set maxVal {}

    # the values for the zeroth item
    for {set w 0} {$w <= $maxWeight} {incr w} {
        set maxVal(0,$w) 0
    }

    for {set i 1; set j 0} {$i <= $n} {incr i; incr j} {
        set wi [lindex $weights $i]
        set vi [lindex $values  $i]
        for {set w 0} {$w <= $maxWeight} {incr w} {
            if {$wi > $w} {
                set maxVal($i,$w) $maxVal($j,$w)
            } else {
                set ww [expr {$w - $wi}]
                set maxVal($i,$w) [expr {max($maxVal($j,$w), $maxVal($j,$ww) + $vi)}]
            }
        }
    }
    return $maxVal($n,$maxWeight)
}
