namespace eval Grep {
    namespace export grep

    variable pattern
    variable files
    variable opts

    proc grep {args} {
        variable files
        parseArgs {*}$args
        set output {}
        foreach file $files {
            lappend output {*}[processFile $file]
        }
        return [join $output \n]
    }

    # For more robust command line switch parsing: 
    # https://core.tcl-lang.org/tcllib/doc/trunk/embedded/md/tcllib/files/modules/cmdline/cmdline.md
    #
    proc parseArgs {args} {
        variable pattern
        variable files
        variable opts

        # set the defaults
        set opts { i false l false n false v false x false }

        # keep looping until a non-switch is found
        while {1} {
            set arg [lindex $args 0]
            if {[regexp {^-([ilnvx])$} $arg -> opt]} {
                dict set opts $opt true
                set args [lrange $args 1 end]
                continue
            }
            break
        }

        # I'll be using opts(v) as an integer later
        dict set opts v [expr {!![dict get $opts v]}]

        set files [lassign $args pattern]

        if {[dict get $opts i]} {
            # -i == case-insensitive matching
            set pattern [string tolower $pattern]
        }
        if {[dict get $opts x]} {
            # -x == whole line matching
            set pattern "^${pattern}$"
        }
    }

    proc processFile {file} {
        variable files
        variable opts
        variable pattern

        set fid [open $file r]
        set lineno 0
        set result {}

        while {[gets $fid line] != -1} {
            incr lineno

            # -i == case insensitive
            if {[dict get $opts i]} {
                set matched [regexp $pattern [string tolower $line]]
            } else {
                set matched [regexp $pattern $line]
            }

            # XOR operator
            #     matched and not -v, or
            # not matched and     -v
            if {$matched ^ [dict get $opts v]} {
                if {[dict get $opts l]} {
                    # -l == filename only
                    lappend result $file
                    break
                } else {
                    set prefix ""
                    if {[llength $files] > 1} {
                        # multiple files, show filename with match
                        append prefix "$file:"
                    }
                    if {[dict get $opts n]} {
                        # -n == show line number with match
                        append prefix "$lineno:"
                    }
                    lappend result "${prefix}${line}"
                }
            }
        }
        close $fid
        return $result
    }
}

namespace import Grep::grep
