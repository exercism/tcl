namespace eval FoodChain {
    namespace export recite

    proc recite {from to} {
        set verses {}
        for {set i $from} {$i <= $to} {incr i} {
            lappend verses [verse $i]
        }
        return [join [lmap v $verses {join $v \n}] \n\n]
    }

    variable menu {
        fly {
            killer no 
        }
        spider {
            tag   " that wriggled and jiggled and tickled inside her"
            rhyme "It wriggled and jiggled and tickled inside her."
            killer no
        }
        bird {
            rhyme "How absurd to swallow a bird!"
            killer no
        }
        cat {
            rhyme "Imagine that, to swallow a cat!"
            killer no
        }
        dog {
            rhyme "What a hog, to swallow a dog!"
            killer no
        }
        goat {
            rhyme "Just opened her throat and swallowed a goat!"
            killer no
        }
        cow {
            rhyme "I don't know how she swallowed a cow!"
            killer no
        }
        horse {
            rhyme "She's dead, of course!"
            killer yes
        }
    }

    proc verse {n} {
        variable menu
        set beasts [dict keys $menu]
        set beast [lindex $beasts $n-1]

        set lines [list "I know an old lady who swallowed a $beast."]
        if {[dict exists $menu $beast rhyme]} {
            lappend lines [dict get $menu $beast rhyme]
        }

        if {![dict get $menu $beast killer]} {
            for {set i 1} {$i < $n} {incr i} {
                set j [expr {$i + 1}]
                set predator [lindex $beasts $n-$i]
                set prey     [lindex $beasts $n-$j]
                if {[dict exists $menu $prey tag]} {
                    append prey [dict get $menu $prey tag]
                }
                lappend lines "She swallowed the $predator to catch the $prey."
            }
            lappend lines "I don't know why she swallowed the fly. Perhaps she'll die."
        }
        return $lines
    }
}

namespace import FoodChain::recite
