proc secretHandshake {code} {
    set actions {wink "double blink" "close your eyes" jump}
    set reverse [llength $actions]

    # an `apply` func
    set codeIncludesAction {{code idx} {
        expr {($code & (1 << $idx)) != 0}
    }}

    set handshake {}
    set i 0
    foreach action $actions {
        if {[apply $codeIncludesAction $code $i]} {
            lappend handshake $action
        }
        incr i
    }
    if {[apply $codeIncludesAction $code $reverse]} {
        set handshake [lreverse $handshake]
    }
    return $handshake
}
