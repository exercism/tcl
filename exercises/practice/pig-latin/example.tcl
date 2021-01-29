proc translate {sentence} {
    set result {}

    foreach word [split $sentence] {
        switch -glob -nocase -- [string range $word 0 1] {
            [aeiou]? - 
            xr       - 
            yt       { lappend result "${word}ay" } 
            default  {
                foreach regex {
                    {^ (.?qu)      (.*)  # squeeze    } 
                    {^ ([^aeiou]+) (y.*) # my, rhythm } 
                    {^ ([^aeiou]+) (.*)  # stop, car  }
                } {
                    if {[regsub -nocase -expanded $regex $word {\2\1ay} latinized]} {
                        lappend result $latinized
                        break
                    }
                }
            }
        }
    }

    return [join $result]
}
