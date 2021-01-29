proc countWords {sentence} {
    set re {
        \m (?:
            \d+ |                               # digits, or
            [[:alpha:]]+ (?: ' [[:alpha:]]+ )?  # words, contractions
        ) \M
    }

    set words [regexp -all -inline -expanded $re $sentence]
    set result [dict create]
    foreach word $words {
        dict incr result [string tolower $word]
    }
    return $result
}
