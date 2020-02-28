namespace eval primeNumbers {
    namespace export nthPrime

    proc nthPrime {idx} {
        if {$idx == 0} {
            error "there is no zeroth prime"
        }
        coroutine nextPrime PrimeNumberGenerator
        while {[incr count] <= $idx} {
            set prime [nextPrime]
        }
        return $prime
    }

    proc PrimeNumberGenerator {} {
        yield [info coroutine]
        yield 2
        set prime 3
        while 1 {
            yield $prime
            while 1 {
                incr prime 2
                if {[IsPrime $prime]} then break
            }
        }
    }

    proc IsPrime {n} {
        if {$n < 2} {
            return false
        }
        if {$n == 2} {
            return true
        }
        if {$n % 2 == 0} {
            return false
        }
        set sqrt [expr {int(sqrt($n))}]
        for {set i 3} {$i <= $sqrt} {incr i 2} {
            if {$n % $i == 0} {
                return false
            }
        }
        return true
    }
}

namespace import primeNumbers::nthPrime
