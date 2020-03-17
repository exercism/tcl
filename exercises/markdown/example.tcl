oo::class create MarkDown {
    variable lines
    variable inList
    variable rendered

    constructor {markdownText} {
        set lines [split $markdownText \n]
        set inList false
        set rendered ""
    }

    method parse {} {
        foreach line $lines {
            my render [my inlineFormatting $line]
        }
        my closeList
        return $rendered
    }

    method render {line} {
        if {[my header   $line]} then return
        if {[my listItem $line]} then return
        my paragraph $line
    }

    method header {line} {
        set re {
            ^           # start of string
            (\#{1,6})   # 1 to 6 hashes
            \s+         # some whitespace
            (.*)        # the text of the heading
        }
        if {[regexp -expanded $re $line -> h heading]} {
            my closeList
            set tag "h[string length $h]"
            append rendered "<$tag>$heading</$tag>"
            return true
        }
        return false
    }

    method listItem {line} {
        set re {
            ^       # start of string
            \*      # the bullet marker
            \s+     # whitespace
            (.*)    # the list item text
        }
        if {[regexp -expanded $re $line -> text]} {
            my openList
            append rendered "<li>$text</li>"
            return true
        }
        return false
    }

    method paragraph {line} {
        my closeList
        append rendered "<p>$line</p>"
    }

    method openList {} {
        if {!$inList} {
            append rendered "<ul>"
            set inList true
        }
    }

    method closeList {} {
        if {$inList} {
            append rendered "</ul>"
            set inList false
        }
    }

    # This method is not quite correct for a proper markdown parser.
    # Simply due to nature of parsing with regular expressions, this
    # cannot properly render bold AND emphasized text:
    #    parse "this is ___bold and italic___ text"
    #    => "<p>this is <strong><em>bold and italic</strong></em> text</p>"
    #    =>                                          ^^^^^^<->^^
    #    =>                                          wrong order
    #
    method inlineFormatting {line} {
        set line [my strong $line]
        set line [my em $line]
        return $line
    }

    method em {text} {
        return [regsub -all {_(.+?)_} $text {<em>\1</em>}]
    }

    method strong {text} {
        return [regsub -all {__(.+?)__} $text {<strong>\1</strong>}]
    }

    # private methods
    unexport render header listItem paragraph
    unexport openList closeList
    unexport inlineFormatting em strong
}


proc parse {text} {
    return [[MarkDown new $text] parse]
}
