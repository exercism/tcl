proc countWords {sentence} {

    # A "word" is"
    # 1. A _number_ composed of one or more ASCII digits (ie "0" or "1234") OR
    # 2. A _simple word_ composed of one or more ASCII letters (ie "a" or "they") OR
    # 3. A _contraction_ of two _simple words_ joined by a single apostrophe (ie "it's" or "they're")

    set re {
        \m (?:
            \d+
            |
            [[:alpha:]]+ (?: ' [[:alpha:]]+ )?
        ) \M
    }

    set words [regexp -all -inline -expanded $re $sentence]
    set result [dict create]
    foreach word $words {
        dict incr result [string tolower $word]
    }
    return $result
}
