namespace eval atbash {
    namespace export encode decode
    namespace ensemble create

    variable map {
        a z   b y   c x   d w   e v   f u   g t   h s   i r   
        j q   k p   l o   m n   n m   o l   p k   q j   r i
        s h   t g   u f   v e   w d   x c   y b   z a
    }

    proc encode {phrase} {
        set encoded [transliterate $phrase]
        return [grouped $encoded]
    }

    proc decode {phrase} {
        return [transliterate $phrase]
    }

    proc transliterate {phrase} {
        variable map
        # prepare the input
        set input [regsub -all {[^[:alnum:]]} $phrase {}]
        set input [string tolower $input]
        # and perform the translation
        return [string map $map $input]
    }
    
    proc grouped {str {size 5}} {
        return [join [regexp -inline -all ".{1,$size}" $str] " "]
    }
}
