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

proc isGameOver {} {
    return [expr {$::state ne "ongoing"}]
}

proc guess {letter} {
    global maskMap guesses word state

    if {![dict exists $maskMap $letter] ||
        [dict get $maskMap $letter] eq $letter ||
        [string first $letter $word] == -1
    } {
        # not a letter, or already guessed it, or bad guess
        incr guesses -1
    } else {
        # register successful guess
        dict set maskMap $letter $letter
    }

    if {[mask] eq $word} {
        set state win
    } elseif {$guesses == 0} {
        set state lose
    }
}

proc handleIO {sock} {
    if {[eof $sock] || [catch {gets $sock line}] != 0} {
        puts "eof or can't read a line on $sock"
        close $sock
        return
    }

    # The `split` command doesn't handle _sequences_ of whitespace.
    # This regex matches a word optionally followed by whitespace
    # and a word character
    set re { (\w+) (?: \s+ (\w) )? }

    if {![regexp -expanded $re [string toupper $line] -> cmd letter]} {
        puts $sock [list ERROR "no command given"]
        return
    }

    switch -exact -- $cmd {
        SHUTDOWN {
            set ::done yes
        }
        STATUS {
            puts $sock [currentStatus]
        }
        GUESS {
            guess $letter
            puts $sock [currentStatus]
            if {[isGameOver]} {
                set ::done yes
            }
        }
        default {
            puts $sock [list ERROR "unknown subcommand $cmd"]
        }
    }
}

proc incomingConnection {sock addr port} {
    fconfigure $sock -buffering line
    fileevent $sock readable [list handleIO $sock]
}

proc startServer {port} {
    set s [socket -server incomingConnection $port]
    # enter the event loop
    vwait done
}

set word [string toupper [lindex $argv 0]]
set port [lindex $argv 1]

startServer $port
