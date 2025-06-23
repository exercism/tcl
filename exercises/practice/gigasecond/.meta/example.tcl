proc addGigasecond {datetime} {
    # scan/format times in UTC to avoid DST offsets.
    # date time parsing: try most specific format first
    try {
        set time [clock scan $datetime -format {%Y-%m-%dT%H:%M:%S} -gmt yes]
    } on error {} {
        try {
            set time [clock scan $datetime -format {%Y-%m-%d} -gmt yes]
        } on error {} {
            set time [clock scan $datetime -gmt yes]
        }
    }

    set future [clock add $time 1000000000 seconds -gmt yes]
    return [clock format $future -format {%Y-%m-%dT%H:%M:%S} -gmt yes]
}
