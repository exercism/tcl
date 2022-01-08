dict for {planet orbit} {
    Mercury   0.2408467
    Venus     0.61519726
    Earth     1.0
    Mars      1.8808158
    Jupiter  11.862615
    Saturn   29.447498
    Uranus   84.016846
    Neptune 164.79132
} {
    set secondsPerPlanetYear [expr {$orbit * 31557600}]

    # Because we're defining the proc body with double quotes, we have
    # to escape the command substitution and variable expansions 
    # to delay evaluation until the procedure is called.

    proc "on$planet" {ageInSeconds} "
        return \[expr {1.0 * \$ageInSeconds / $secondsPerPlanetYear}]
    "
}

proc unknown {args} {
    error "not a planet"
}
