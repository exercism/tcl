proc flatten {input} {
    set one_level_flatter [concat {*}$input]
    if {$input eq $one_level_flatter} {
        # their string representations are the same
        return $input 
    } else {
        tailcall flatten $one_level_flatter
    }
}

