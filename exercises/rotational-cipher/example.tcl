proc rotate {text shift} {
    set alphabet {A B C D E F G H I J K L M N O P Q R S T U V W X Y Z}
    set rotated [concat [lrange $alphabet $shift end] [lrange $alphabet 0 $shift-1]]

    foreach A $alphabet \
            R $rotated \
            a [string tolower $alphabet] \
            r [string tolower $rotated] \
    {
        lappend map  $a $r  $A $R
    }

    return [string map $map $text]
}
