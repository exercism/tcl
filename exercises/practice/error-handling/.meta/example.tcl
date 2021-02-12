# works with any Tcl version
proc custom_error_message_error {message} {
    error $message
}

# requires Tcl 8.6
proc custom_error_message_throw {message} {
    throw CUSTOM_EXCEPTION $message
}


# works with any Tcl version
proc handle_error_catch {script} {
    set msg "success"
    if {[catch $script result] != 0} {
        switch -glob -- $result {
            {*divide by zero*}  {set msg "division by zero"}
            {*no such file*}    {set msg "file does not exist"}
            {*invalid command*} {set msg "proc does not exist"}
            default             {set msg "unknown error"}
        }
    }
    return $msg
}

# requires Tcl 8.6
proc handle_error_try_on {script} {
    set msg "success"
    try $script on error errmsg {
        switch -glob -- $errmsg {
            {*divide by zero*}  {set msg "division by zero"}
            {*no such file*}    {set msg "file does not exist"}
            {*invalid command*} {set msg "proc does not exist"}
            default             {set msg "unknown error"}
        }
    }
    return $msg
}

# requires Tcl 8.6
proc handle_error_try_trap {script} {
    set msg "success"
    try {
        uplevel 1 $script
    } trap {ARITH DIVZERO} {} {
        set msg "division by zero"
    } trap {POSIX ENOENT} {} {
        set msg "file does not exist"
    } trap {TCL LOOKUP COMMAND} {} {
        set msg "proc does not exist"
    } trap {} {} {
        set msg "unknown error"
    }
    return $msg
}


if {[package provide Tcl] >= "8.6"} {
    interp alias {} custom_error_message {} custom_error_message_throw
    #interp alias {} handle_error {} handle_error_try_on
    interp alias {} handle_error {} handle_error_try_trap
} else {
    interp alias {} custom_error_message {} custom_error_message_error
    interp alias {} handle_error {} handle_error_catch
}
