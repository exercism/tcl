namespace eval BeerSong {
    namespace export beerSong

    proc beerSong {start take} {
        set lines {}
        for {set i $start} {$i >= $start - $take + 1} {incr i -1} {
            lappend lines [firstLine $i] [secondLine $i]
        }
        return [join $lines \n]
    }

    proc firstLine {n} {
        set b [bottle $n]
        return [format {%s on the wall, %s.} [string totitle $b] $b]
    }

    proc secondLine {n} {
        return [format {%s, %s on the wall.} [action $n] [bottle [incr n -1]]]
    }

    proc bottle {n} {
        set n [switch -- $n {
                  0 {expr {"no more"}} 
                 -1 {expr {99}} 
            default {set n}
        }]
        set s [expr {$n == 1 ? "" : "s"}]
        return "$n bottle$s of beer"
    }

    proc action {n} {
        if {$n == 0} {
            return "Go to the store and buy some more"
        } else {
            set one [expr {$n == 1 ? "it" : "one"}]
            return "Take $one down and pass it around"
        }
    }
}

namespace import BeerSong::beerSong
