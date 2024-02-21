proc reverse {input {reversed ""}} {
    if {$input eq ""} {
        return $reversed
    }
    tailcall reverse \
        [string range $input 1 end] \
        [string cat [string index $input 0] $reversed]
}
