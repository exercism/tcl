# This exercise is less structured than others
throw {NOT_IMPLEMENTED} "Implement this program."

# For starting the server, use a proc like this:
#
proc startServer {} {
    # use port 0 to allow Tcl to find an unused port
    set s [socket -server yourCallbackProc 0]

    # communicate the port number in use
    set sockInfo [chan configure $s -sockname]
    set ::env(HANGMAN_PORT) [lindex $sockInfo 2]
    puts "server started on port $::env(HANGMAN_PORT)"

    # enter the event loop
    vwait aGlobalVarname
}

# get the word from the $argv list, then:
startServer
