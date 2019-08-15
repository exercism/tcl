proc abbreviate {phrase} {
    set words [regexp -all -inline {[[:alpha:]][[:alpha:]']*} $phrase]
    set inits [lmap word $words {string range $word 0 0}]
    return [string toupper [join $inits ""]]
}
