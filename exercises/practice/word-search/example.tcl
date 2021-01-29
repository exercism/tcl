oo::class create WordSearch {
    variable grid height width
    variable foundWords notFound

    constructor {theGrid} {
        set grid [lmap row $theGrid {split $row ""}]
        set height [llength $grid]
        set width [llength [lindex $grid 0]]
    }

    method find {words} {
        set notFound $words
        set foundWords {}
        foreach word $words {
            dict set foundWords $word {}
        }

        for {set r 0} {$r < $height} {incr r} {
            for {set c 0} {$c < $width} {incr c} {
                my searchAt $r $c
                if {[llength $notFound] == 0} {
                    return $foundWords
                }
            }
        }

        return $foundWords
    }

    method searchAt {r c} {
        set letter [lindex $grid $r $c]
        set potentials [lsearch -glob -inline -all $notFound "${letter}*"]
        if {[llength $potentials] == 0} then return

        # sort by length so we look for "javascript" before "java"
        set potentials [lsort -command bylength -decreasing $potentials]

        # look in all directions, starting "up", moving clockwise
        foreach direction {{-1 0} {-1 1} {0 1} {1 1} {1 0} {1 -1} {0 -1} {-1 -1}} {
            lassign $direction dr dc
            set chars [my charsToEdge $r $c $dr $dc]
            foreach word $potentials {
                if {[string first $word $chars] == 0} {
                    my markAsFound $word [my wordIndices $word $r $c $dr $dc]
                    # If we find "javascript" do not also find "java"
                    break
                }
            }
        }
    }

    method markAsFound {word indices} {
        # add it to the found dictionary
        dict set foundWords $word $indices

        # and remove it from the list of not found words
        set idx [lsearch -exact $notFound $word]
        set notFound [lreplace $notFound $idx $idx]
    }

    # return the start and end indices of the word,
    # adjusted for 1-based indexing
    #
    method wordIndices {word r c dr dc} {
        set startRow [expr {$r + 1}]
        set startCol [expr {$c + 1}]

        set len [string length $word]
        set endRow [expr {$r + ($dr * ($len - 1)) + 1}]
        set endCol [expr {$c + ($dc * ($len - 1)) + 1}]

        return [list [list $startCol $startRow] [list $endCol $endRow]]
    }

    # starting from the specified row/column, return the string
    # of characters up to the edge of the grid
    #
    method charsToEdge {row col dr dc} {
        set chars ""
        for {set r $row; set c $col}                            \
            {between($r, 0, $height) && between($c, 0, $width)} \
            {incr r $dr; incr c $dc}                            \
            {append chars [lindex $grid $r $c]}
        return $chars
    }
}

############################################################
proc ::tcl::mathfunc::between {value start end} {
    expr {$start <= $value && $value < $end}
}

proc bylength {a b} {
    set la [string length $a]
    set lb [string length $b]
    expr {$la < $lb ? -1 : ($la > $lb ? 1 : 0)}
}

############################################################
proc wordSearch {grid words} {
    return [[WordSearch new $grid] find $words]
}
