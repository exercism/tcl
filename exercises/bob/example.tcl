proc heyBob {input} {
    set input [string trimright $input]

    # empty
    set silent [expr {$input eq ""}]

    # ends with a "?"
    set asking [string match {*\?} $input]

    # contains an alpha but no lower case
    set yelling [expr {
        [string match -nocase {*[a-z]*} $input] &&
        ! [string match {*[a-z]*} $input]
    }]

    # Tcl's default boolean result is 1/0 for true/false.
    # Using that to combine them as a string:
    switch -glob -- "${silent}${asking}${yelling}" {
        "1??" {return "Fine. Be that way!"}
        "011" {return "Calm down, I know what I'm doing!"}
        "010" {return "Sure."}
        "001" {return "Whoa, chill out!"}
        "000" {return "Whatever."}
    }
}
