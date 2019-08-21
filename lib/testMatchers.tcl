# Some procs that are handy for Tcl test custom matching.
#
# You would use this in a test file like this:
#    source ./testMatchers.tcl
#    customMatch dictionary dictionaryMatch
#    test name "description" -body {
#        code that returns a dictionary
#    } -match dictionary -result {expected dictionary value here}
#
# For exercises that need one of these, copy this file
# into the exercise directory, so the student's download is
# self-contained.


# compare two dictionaries for the same keys and same values
proc dictionaryMatch {expected actual} {
    if {[dict size $expected] != [dict size $actual]} {
        return false
    }
    dict for {key value} $expected {
        if {![dict exists $actual $key]} {
            return false
        }
        if {[dict get $actual $key] != $value} {
            return false
        }
    }
    return true
}


# since Tcl boolean values can be more than just 0/1...
#   set a yes; set b 1
#   expr  {$a == $b} ;# => 0
#   expr  {$a && $b} ;# => 1
proc booleanMatch {expected actual} {
    return [expr {
        [string is boolean -strict $expected] &&
        [string is boolean -strict $actual] &&
        (($expected && $actual) || (!$expected && !$actual))
    }]
}

# The last line _could_ be written with a negated XOR,
# coercing the boolean values into integers:
#     !(!!$expected ^ !!$actual)
# This is less readable, but does compile into more
# efficient bytecode.
