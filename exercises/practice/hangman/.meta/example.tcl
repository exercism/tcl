#!/usr/bin/env tclsh

# global vars
set done no
set state ongoing
set maskMap {
    A _ B _ C _ D _ E _ F _ G _ H _ I _ J _ K _ L _ M _
    N _ O _ P _ Q _ R _ S _ T _ U _ V _ W _ X _ Y _ Z _
}
set guesses 9
set word ""
set port -1

proc mask {} {
    return [string map $::maskMap $::word]
}

proc currentStatus {} {
    return [list $::guesses [mask] $::state]
}

proc guess {sock letter} {
    global maskMap guesses word state

    if {![dict exists $maskMap $letter] ||
        [string first $letter $word] == -1 ||
        [dict get $maskMap $letter] eq $letter
    } {
        # not a letter, or bad guess, or already guessed it
        incr guesses -1
    } else {
        # register successful guess
        dict set maskMap $letter $letter
    }

    set prevState $state
    if {[mask] eq $word} {
        set state win
    } elseif {$guesses == 0} {
        set state lose
    }

    set status [currentStatus]
    puts $sock $status

    if {$prevState ne $state} {
        # setting this variable breaks out of the event loop
        set ::done yes
    }
}

proc handleInput {sock} {
    if {[eof $sock] || [catch {gets $sock line}] != 0} {
        puts "eof or can't read a line on $sock"
        close $sock
        return
    }

    set words [split $line]
    set cmd [lindex $words 0]

    switch -exact -- [string toupper $cmd] {
        SHUTDOWN {
            exit
        }
        STATUS {
            puts $sock [currentStatus]
        }
        GUESS {
            set guess [string trimleft [lindex $words 1]]
            set letter [string toupper [string index $guess 0]]
            guess $sock $letter
        }
        default {
            puts $sock [list ERROR "unknown subcommand $cmd"]
        }
    }
}

proc incomingConnection {sock addr port} {
    fconfigure $sock -buffering line
    fileevent $sock readable [list handleInput $sock]
}

proc startServer {port} {
    set s [socket -server incomingConnection $port]
    vwait done
}

# read command line arguments
lassign $argv word port
set word [string toupper $word]

startServer $port
