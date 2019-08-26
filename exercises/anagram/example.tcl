proc findAnagrams {subject candidates} {
    set result {}
    set subj [string tolower $subject]
    set subjKey [key $subj]

    foreach candidate $candidates {
        set cand [string tolower $candidate]
        if {$subj ne $cand && $subjKey eq [key $cand]} {
            lappend result $candidate
        }
    }

    return $result   
}

proc key {word} {
    return [join [lsort [split $word ""]] ""]
}
