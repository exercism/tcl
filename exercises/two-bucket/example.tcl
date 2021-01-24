proc twoBucket {input} {
    array set args $input
    set puzzle [TwoBucket new $args(bucketOne) $args(bucketTwo) $args(goal) $args(startBucket)]
    return [$puzzle solve]
}

oo::class create TwoBucket {
    variable startBucket
    variable otherBucket
    variable goal

    constructor {b1Size b2Size theGoal startName} {
        my Validate $b1Size $b2Size $theGoal $startName

        set goal $theGoal
        set bucketOne [Bucket new "one" $b1Size]
        set bucketTwo [Bucket new "two" $b2Size]

        if {$startName eq "one"} {
            set startBucket $bucketOne
            set otherBucket $bucketTwo
        } else {
            set startBucket $bucketTwo
            set otherBucket $bucketOne
        }
    }
    
    method Validate {b1Size b2Size theGoal startName} {
        if {$startName ni {one two}} {
            error "invalid start bucket: $startName"
        }
        if {$theGoal > max($b1Size, $b2Size)} {
            error "impossible: goal is too big"
        }
        set gcd [expr {gcd($b1Size, $b2Size)}]
        if {$gcd > 1 && $theGoal % $gcd != 0} {
            # example b1 = 15, b2 = 10, goal = 7
            error "impossible: goal is unsatisfiable"
        }
    }

    method solve {} {
        set steps 0

        $startBucket fill
        incr steps

        if {[$otherBucket capacity] == $goal} {
            $otherBucket fill
            incr steps
        }

        while 1 {
            if {[$startBucket amount] == $goal} {
                return [my ReturnData $steps $startBucket $otherBucket]
            }
            if {[$otherBucket amount] == $goal} {
                return [my ReturnData $steps $otherBucket $startBucket]
            }

            if {[$startBucket isEmpty]} {
                $startBucket fill
            } elseif {[$otherBucket isFull]} {
                $otherBucket empty
            } else {
                $startBucket pourInto $otherBucket
            }
            incr steps
        }
    }

    method ReturnData {steps winner loser} {
        return [dict create moves $steps goalBucket [$winner name] otherBucket [$loser amount]]
    }
}

proc ::tcl::mathfunc::gcd {a b} {
    if {$b == 0} {
        return $a
    }
    set procname [lindex [info level 0] 0]
    tailcall $procname $b [expr {$a % $b}]
}

oo::class create Bucket {
    variable amount
    variable name
    variable size

    constructor {aName aSize} {
        set name $aName
        set size $aSize
        set amount 0
    }

    # getters
    method name {} {
        return $name
    }

    method amount {} {
        return $amount
    }

    method capacity {} {
        return [expr {$size - $amount}]
    }

    # tests
    method isEmpty {} {
        return [expr {$amount == 0}]
    }

    method isFull {} {
        return [expr {$amount == $size}]
    }

    # actions
    method add {anAmount} {
        incr amount $anAmount
        return [self]
    }

    method remove {anAmount} {
        incr amount -$anAmount
        return [self]
    }

    method empty {} {
        my remove $amount
        return [self]
    }

    method fill {} {
        my add [my capacity]
        return [self]
    }

    method pourInto {other} {
        set amt [expr {min($amount, [$other capacity])}]
        my remove $amt
        $other add $amt
        return [self]
    }
}
