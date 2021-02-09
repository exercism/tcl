namespace eval KindergartenGarden {
    namespace export plants

    variable students {
        Alice  Bob      Charlie  David   Eve      Fred 
        Ginny  Harriet  Ileana   Joseph  Kincaid  Larry
    }

    variable plantmap {V violets G grass C clover R radishes}

    proc plants {diagram student} {
        variable students
        variable plantmap

        lassign [split $diagram \n] top bottom
        set plots [lmap \
            tt [regexp -all -inline {..} $top] \
            bb [regexp -all -inline {..} $bottom] \
            {string cat $tt $bb}]

        set idx [lsearch -exact $students $student]
        set plot [lindex $plots $idx]
        return [lmap p [split $plot ""] {dict get $plantmap $p}]
    }
}

namespace import KindergartenGarden::plants
