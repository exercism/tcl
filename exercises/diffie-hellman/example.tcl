namespace eval diffieHellman {}

proc diffieHellman::privateKey {p} {
    # a random number in the range [2, p)
    return [expr {2 + int(($p - 2) * rand())}]
}

proc diffieHellman::publicKey {p g private} {
    return [expr {($g ** $private) % $p}]
}

proc diffieHellman::secret {p public private} {
    return [publicKey $p $public $private]
}
