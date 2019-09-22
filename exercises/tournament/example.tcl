oo::class create Tournament {
    variable inputFile
    variable results

    constructor {filename} {
        if {![file readable $filename]} {
            error "cannot read file $filename"
        }
        set inputFile $filename
    }

    # public
    # (only methods named [a-z]* are exported by default)

    method standings {} {
        my variable results
        my Readfile

        set standings {}
        dict for {team stats} $results {
            dict with stats {
                set mp [expr {$w + $d + $l}]
                set p  [expr {3 * $w + $d}]
                lappend standings [list $team $mp $w $d $l $p]
            }
        }

        set fmt "%-30s | %2s | %2s | %2s | %2s | %2s"
        set report [list [format $fmt Team MP W D L P]]

        foreach entry [my Sorted $standings] {
            lappend report [format $fmt {*}$entry]
        }
        return [join $report \n]
    }

    # private

    method Readfile {} {
        my variable inputFile results
        set results {}
        set fh [open $inputFile r]

        while {[gets $fh line] != -1} {
            lassign [split $line ";"] home away result
            # ignore invalid lines
            if {$home eq "" || $away eq "" || $result ni {win loss draw}} {
                continue
            }
            switch -- $result {
                "win"  { my Win  $home; my Loss $away }
                "loss" { my Loss $home; my Win  $away }
                "draw" { my Draw $home; my Draw $away }
            }
        }
        close $fh
    }

    method Win {team} {
        my Incr $team w
    }

    method Loss {team} {
        my Incr $team l
    }

    method Draw {team} {
        my Incr $team d
    }

    method Incr {team key} {
        my variable results
        if {![dict exists $results $team]} {
            dict set results $team {w 0 l 0 d 0}
        }
        dict update results $team entry {
            dict incr entry $key
        }
    }

    method Sorted {standings} {
        return [lsort -int  -decr -index end \
               [lsort -dict -incr -index 0   $standings]]
    }
}

proc tournamentResults {filename} {
    return [[Tournament new $filename] standings]
}
