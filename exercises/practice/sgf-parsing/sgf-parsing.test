#!/usr/bin/env tclsh
package require tcltest
namespace import ::tcltest::*
source testHelpers.tcl

# uncomment for more verbose test results
#configure -verbose {body error usec}

############################################################
source "sgf-parsing.tcl"

test sgf-parsing-1 "empty input" -body {
    set input {}
    parse $input
} -returnCodes error -result "tree missing"

skip sgf-parsing-2
test sgf-parsing-2 "tree with no nodes" -body {
    set input {()}
    parse $input
} -returnCodes error -result "tree with no nodes"

skip sgf-parsing-3
test sgf-parsing-3 "node without tree" -body {
    set input {;}
    parse $input
} -returnCodes error -result "tree missing"

skip sgf-parsing-4
test sgf-parsing-4 "node without properties" -body {
    set input {(;)}
    parse $input
} -returnCodes ok -match sgfTree -result {
    properties {}
    children {}
}

skip sgf-parsing-5
test sgf-parsing-5 "single node tree" -body {
    set input {(;A[B])}
    parse $input
} -returnCodes ok -match sgfTree -result {
    properties {
        A {B}
    }
    children {}
}

skip sgf-parsing-6
test sgf-parsing-6 "multiple properties" -body {
    set input {(;A[b]C[d])}
    parse $input
} -returnCodes ok -match sgfTree -result {
    properties {
        A {b}
        C {d}
    }
    children {}
}

skip sgf-parsing-7
test sgf-parsing-7 "properties without delimiter" -body {
    set input {(;A)}
    parse $input
} -returnCodes error -result "properties without delimiter"

skip sgf-parsing-8
test sgf-parsing-8 "all lowercase property" -body {
    set input {(;a[b])}
    parse $input
} -returnCodes error -result "property must be in uppercase"

skip sgf-parsing-9
test sgf-parsing-9 "upper and lowercase property" -body {
    set input {(;Aa[b])}
    parse $input
} -returnCodes error -result "property must be in uppercase"

skip sgf-parsing-10
test sgf-parsing-10 "two nodes" -body {
    set input {(;A[B];B[C])}
    parse $input
} -returnCodes ok -match sgfTree -result {
    properties {
        A {B}
    }
    children {
        {
            properties {
                B {C}
            }
            children {}
        }
    }
}

skip sgf-parsing-11
test sgf-parsing-11 "two child trees" -body {
    set input {(;A[B](;B[C])(;C[D]))}
    parse $input
} -returnCodes ok -match sgfTree -result {
    properties {
        A {B}
    }
    children {
        {
            properties {
                B {C}
            }
            children {}
        }
        {
            properties {
                C {D}
            }
            children {}
        }
    }
}

skip sgf-parsing-12
test sgf-parsing-12 "multiple property values" -body {
    set input {(;A[b][c][d])}
    parse $input
} -returnCodes ok -match sgfTree -result {
    properties {
        A {b c d}
    }
    children {}
}

skip sgf-parsing-13
test sgf-parsing-13 "within property values, whitespace characters such as tab are converted to spaces" -body {
    set input {(;A[hello\t\tworld])}
    parse $input
} -returnCodes ok -match sgfTree -result {
    properties {
        A {"hello  world"}
    }
    children {}
}

skip sgf-parsing-14
test sgf-parsing-14 "within property values, newlines remain as newlines" -body {
    set input {(;A[hello\n\nworld])}
    parse $input
} -returnCodes ok -match sgfTree -result {
    properties {
        A {"hello\n\nworld"}
    }
    children {}
}

skip sgf-parsing-15
test sgf-parsing-15 "escaped closing bracket within property value becomes just a closing bracket" -body {
    set input {(;A[\]])}
    parse $input
} -returnCodes ok -match sgfTree -result {
    properties {
        A {{]}}
    }
    children {}
}

skip sgf-parsing-16
test sgf-parsing-16 "escaped backslash in property value becomes just a backslash" -body {
    set input {(;A[\\])}
    parse $input
} -returnCodes ok -match sgfTree -result {
    properties {
        A {"\\"}
    }
    children {}
}

skip sgf-parsing-17
test sgf-parsing-17 "opening bracket within property value doesn't need to be escaped" -body {
    set input {(;A[x[y\]z][foo]B[bar];C[baz])}
    parse $input
} -returnCodes ok -match sgfTree -result {
    properties {
        A {{x[y]z} foo}
        B {bar}
    }
    children {
        {
            properties {
                C {baz}
            }
            children {}
        }
    }
}

skip sgf-parsing-18
test sgf-parsing-18 "semicolon in property value doesn't need to be escaped" -body {
    set input {(;A[a;b][foo]B[bar];C[baz])}
    parse $input
} -returnCodes ok -match sgfTree -result {
    properties {
        A {a;b foo}
        B {bar}
    }
    children {
        {
            properties {
                C {baz}
            }
            children {}
        }
    }
}

skip sgf-parsing-19
test sgf-parsing-19 "parentheses in property value don't need to be escaped" -body {
    set input {(;A[x(y)z][foo]B[bar];C[baz])}
    parse $input
} -returnCodes ok -match sgfTree -result {
    properties {
        A {x(y)z foo}
        B {bar}
    }
    children {
        {
            properties {
                C {baz}
            }
            children {}
        }
    }
}

skip sgf-parsing-20
test sgf-parsing-20 "escaped t and n in property value are just letters, not whitespace" -body {
    set input {(;A[\\t = t and \\n = n])}
    parse $input
} -returnCodes ok -match sgfTree -result {
    properties {
        A {"t = t and n = n"}
    }
    children {}
}

skip sgf-parsing-21
test sgf-parsing-21 "escaped tab in property value is converted to space" -body {
    set input {(;A[hello\\\tworld])}
    parse $input
} -returnCodes ok -match sgfTree -result {
    properties {
        A {"hello world"}
    }
    children {}
}

skip sgf-parsing-22
test sgf-parsing-22 "escaped newline in property value is converted to nothing at all" -body {
    set input {(;A[hello\\\nworld])}
    parse $input
} -returnCodes ok -match sgfTree -result {
    properties {
        A {helloworld}
    }
    children {}
}

skip sgf-parsing-23
test sgf-parsing-23 "mixing various kinds of whitespace and escaped characters in property value" -body {
    set input {(;A[\]b\nc\\\nd\t\te\\\\ \\\n\]])}
    parse $input
} -returnCodes ok -match sgfTree -result {
    properties {
        A {"]b\ncd  e\\ ]"}
    }
    children {}
}

cleanupTests
