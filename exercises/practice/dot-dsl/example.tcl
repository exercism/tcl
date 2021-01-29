# The DOT syntax is _quite_ close to Tcl syntax.
#
# We will define the `graph` instructions as a Tcl command
# to process the DOT file.
#
# To guard against malicious intent, we will use a safe interpreter.

############################################################
oo::class create Graph {
    variable nodes edges attributes

    constructor {} {
        set nodes {}
        set edges {}
        set attributes {}
    }

    method toDict {} {
        list nodes $nodes edges $edges attrs $attributes
    }

    method addNode {name {attrs {}}} {
        if {![string is alnum -strict $name]} {
            error "node name must be alphanumeric"
        }
        dict set nodes $name $attrs
    }

    method hasNode {name} {
        dict exists $nodes $name
    }

    method addEdge {a b {attrs {}}} {
        if {![my hasNode $a]} then {my addNode $a}
        if {![my hasNode $b]} then {my addNode $b}
        dict set edges [lsort [list $a $b]] $attrs
    }

    method addAttribute {{attr ""}} {
        if {$attr ne ""} {
            lassign $attr key value
            dict set attributes $key $value
        }
    }
}

############################################################
namespace eval DotReader {
    namespace export processDotFile

    proc processDotFile {filename} {
        if {![file exists $filename] || ![file readable $filename]} {
            error "cannot read file"
        }

        set interp [interp create -safe]
        interp share "" stdout $interp   ;# to allow debug msgs
        addDslCommands $interp

        # create a `graphObj` command in the safe interp that 
        # aliases the `$graph` object from this main interp.
        set graph [Graph new]
        interp alias $interp graphObj {} $graph

        $interp invokehidden source $filename

        return [$graph toDict]
    }

    proc addDslCommands {interp} {
        $interp eval { 

            proc graph {definition} {
                foreach line [split $definition \n] {
                    set line [string trim $line]
                    if {$line eq ""} then continue
                    # comments
                    if {[regexp {^\s*(?:#|//)} $line]} then continue
                    regsub {;$} $line "" line

                    lassign [extractAttribute $line] line attr

                    processWords [regexp -inline -all {\S+} $line] $attr
                }
            }

            # if a line has an attribute, it will be the last "word"
            #
            proc extractAttribute {line} {
                set attr {}
                if {[regexp {\[(.*?)\]$} $line attrText attr]} {
                    if {![regexp {^(.+?)=(.+)$} $attr -> key value]} {
                        error "invalid attribute"
                    }
                    regsub {^"(.+)"$} $value {\1} value
                    set attr [list $key $value]
                    set line [string map [list $attrText ""] $line]
                }
                return [list $line $attr]
            }

            proc processWords {words attr} {
                switch [llength $words] {
                    0 { graphObj addAttribute $attr }
                    1 { graphObj addNode [lindex $words 0] $attr }
                    default { 
                        while {[llength $words] > 1} {
                            set rest [lassign $words a edge b]
                            if {$edge ne "--" || $b eq ""} {
                                error "invalid edge"
                            }
                            graphObj addEdge $a $b $attr 
                            set words [concat $b $rest]
                        }
                    }
                }
            }
        }
    }
}

############################################################
namespace import DotReader::processDotFile
