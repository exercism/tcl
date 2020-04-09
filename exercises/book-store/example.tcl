namespace eval BookStore {
    namespace export cost

    # cost in cents
    variable bookPrice 800
    variable maxGroupSize 5
    variable discountTiers {0 5 10 20 25}

    # cost in cents
    proc cost {basket} {
        tailcall costRecursive [reorderBooks $basket]
    }

    proc costOfGroupSize {n} {
        variable bookPrice
        variable maxGroupSize
        variable discountTiers

        if {$n < 1 || $n > $maxGroupSize} {
            error "Invalid group size $n"
        }
        set discount [lindex $discountTiers $n-1]
        expr {$bookPrice * $n * (100 - $discount) / 100}
    }

    proc costRecursive {books {costSoFar 0}} {
        if {[llength $books] == 0} {
            return $costSoFar
        }

        set distinctBooks [ldistinct $books]
        set minPrice Inf

        for {set i 0} {$i < [llength $distinctBooks]} {incr i} {
            set newGroupBooks [lrange $distinctBooks 0 $i]
            set costOfNewGroup [costOfGroupSize [llength $newGroupBooks]]

            set remainingBooks $books
            foreach book $newGroupBooks {
                set remainingBooks [lremoveFirst $remainingBooks $book]
            }

            # I hate hardcoding the name of a recursive proc in the proc
            set procname [lindex [info level 0] 0]
            set price [$procname $remainingBooks [expr {$costSoFar + $costOfNewGroup}]]
            set minPrice [expr {min($minPrice, $price)}]
        }
        return $minPrice
    }

    # Reorder the books in the basket so that the books with
    # the largest *count* appear first:
    #
    # given:  {1 2 3 4 5 2 3 4 5 3 4 5}
    # return: {3 3 3 4 4 4 5 5 5 2 2 1}
    #
    proc reorderBooks {basket} {
        set counts [dict create]
        foreach book $basket {
            dict incr counts $book
        }
        # the counts ordered by count descending
        set counts [lsort -integer -decreasing -stride 2 -index end $counts]

        set reordered {}
        dict for {book count} $counts {
            lappend reordered {*}[lrepeat $count $book]
        }
        return $reordered
    }
}

interp alias {} basketCost {} BookStore::cost


############################################################
# Some utility procs

# Find the distinct elements of this list, without sorting
proc ldistinct {list} {
    set d [dict create]
    foreach elem $list {dict set d $elem ""}
    return [dict keys $d]
}

# Remove the *first* instance of the elem from the list
proc lremoveFirst {list elem} {
    set idx [lsearch -exact $list $elem]
    if {$idx != -1} {
        return [lreplace $list $idx $idx]
    } else {
        return $list
    }
}
