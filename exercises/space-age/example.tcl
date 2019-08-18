namespace eval spaceAge {
    variable relativeOrbits {
        Mercury   0.2408467
        Venus     0.61519726
        Earth     1.0
        Mars      1.8808158
        Jupiter  11.862615
        Saturn   29.447498
        Uranus   84.016846
        Neptune 164.79132
    }

    foreach {planet relativeOrbit} $relativeOrbits {
        proc "on$planet" {age} "
            return \[calculate \$age $relativeOrbit]
        "
        namespace export "on$planet"
    }

    proc calculate {age orbit} {
        set secondsPerEarthYear 31557600
        set years [expr {1.0 * $age / $orbit / $secondsPerEarthYear}]
        return [format {%.2f} $years]
    }
}

namespace import spaceAge::*
