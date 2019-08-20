package require oo::util

oo::class create Robot {
    classmethod init {} {
        classvariable namesInUse
        set namesInUse [dict create]
    }

    constructor {} {
        classvariable namesInUse
        my variable name
        #set classNS [info object namespace [self class]]
        #my eval [list namespace upvar $classNS namesInUse namesInUse]
        set name [my NewName]
    }

    method name {} {
        my variable name
        return $name
    }

    method resetName {} {
        my variable name
        classvariable namesInUse
        dict unset namesInUse $name
        set name [my NewName]
    }

    method NewName {} {
        classvariable namesInUse
        while true {
            set randName [my RandomName]
            if {[dict exists $namesInUse $randName]} {
                continue
            }
            # an unused name
            set name $randName
            dict set namesInUse $randName 1
            break
        }
    }

    method RandomName {} {
        set alpha {{} {expr { 65 + int(26 * rand()) }}}
        set num   {{} {expr { int(1000 * rand()) }}}
        return [format {%c%c%03d} [apply $alpha] [apply $alpha] [apply $num]]
    }
}

Robot init
