proc encode {string} {
    if {[regexp {\d} $string]} {
        error "cannot run-length-encode numbers"
    }
    set tmp [regsub -all {(.)\1+} $string {[string length "\0"]\1}]
    return [subst -novariables -nobackslashes $tmp]
}

proc decode {code} {
    set tmp [regsub -all {(\d+)(.)} $code {[string repeat "\2" \1]}]
    return [subst -novariables -nobackslashes $tmp]
}
